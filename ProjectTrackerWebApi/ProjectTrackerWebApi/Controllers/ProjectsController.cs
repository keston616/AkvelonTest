using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Description;
using ProjectTrackerWebApi.Models;

namespace ProjectTrackerWebApi.Controllers
{
    public class ProjectsController : ApiController
    {
        private TaskTrackerDBEntities db = new TaskTrackerDBEntities();


        // Get a list of all projects
        [Route("api/Projects/GetAll")]
        public IHttpActionResult GetAll()
        {
            var post = from e in db.Project
                       select new
                       {
                           ID = e.Id,
                           Name = e.Name,
                           StartDate = e.StartDate,
                           CompletionDate = e.CompletionDate,
                           Priority = e.Priority,
                           StatusProject = e.StatusProject.Name,
                       };
            return Ok(post);
        }

        // Search for a project by Id
        [ResponseType(typeof(Project))]
        public IHttpActionResult GetProject(int id)
        {
            Project project = db.Project.Find(id);
            if (project == null)
            {
                return NotFound();
            }

            var obj = new
            {
                ID = project.Id,
                Name = project.Name,
                StartDate = ((DateTime)project.StartDate).ToString("dd.MM.yyyy"),
                CompletionDate = ((DateTime)project.CompletionDate).ToString("dd.MM.yyyy"),
                Priority = project.Priority,
                StatusProject = project.StatusProject.Name,
                Tasks = from e in project.Task
                        select new
                           {
                               ID = e.id,
                               Name = e.Name,
                               Description = e.Description,
                               Priority = e.Priority,
                               Status = e.StatusTask.Name
                           }
            };
            return Ok(obj);
        }

        // Update the project information by the specified id
        [ResponseType(typeof(void))]
        public IHttpActionResult PutProject(int id, Project project)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != project.Id)
            {
                return BadRequest();
            }

            db.Entry(project).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ProjectExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return StatusCode(HttpStatusCode.NoContent);
        }

        // Add a new project
        [ResponseType(typeof(Project))]
        public IHttpActionResult PostProject(Project project)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Project.Add(project);
            db.SaveChanges();

            return CreatedAtRoute("DefaultApi", new { id = project.Id }, project);
        }

        // Deleted a project
        [ResponseType(typeof(Project))]
        public IHttpActionResult DeleteProject(int id)
        {
            Project project = db.Project.Find(id);
            if (project == null)
            {
                return NotFound();
            }

            db.Project.Remove(project);
            db.SaveChanges();

            return Ok(project);
        }



        // Sort by Priority, Date, ascending and descending
        [HttpGet]
        [Route("api/Projects/SortProjects/{nameField}")]
        public IHttpActionResult SortProjects(string nameField, string desc)
        {

            var post = from e in db.Project
                       select new
                       {
                           ID = e.Id,
                           Name = e.Name,
                           StartDate = e.StartDate,
                           CompletionDate = e.CompletionDate,
                           Priority = e.Priority,
                           StatusProject = e.StatusProject.Name,
                       };

            switch (nameField.ToLower())
            {
                case "priority": 
                    post = post.OrderBy(x=>x.Priority); 
                    break;

                case "startdate": 
                    post = post.OrderBy(x => x.StartDate);
                    break;

                case "completiondate": 
                    post = post.OrderBy(x => x.CompletionDate); 
                    break;

                default: 
                    return NotFound();
            }
            if (desc == "desc")
            {
                post = post.OrderByDescending(x => x.Priority);
            }
            return Ok(post);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool ProjectExists(int id)
        {
            return db.Project.Count(e => e.Id == id) > 0;
        }
    }
}