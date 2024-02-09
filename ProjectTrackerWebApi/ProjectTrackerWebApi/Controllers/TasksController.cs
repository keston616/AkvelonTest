using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Description;
using ProjectTrackerWebApi.Models;

namespace ProjectTrackerWebApi.Controllers
{
    public class TasksController : ApiController
    {
        private TaskTrackerDBEntities db = new TaskTrackerDBEntities();


        // Get a list of all tasks
        [Route("api/Tasks/GetAll")]
        public IHttpActionResult GetAll()
        {
            var post = from e in db.Task
                       select new
                       {
                           ID = e.id,
                           Name = e.Name,
                           Description = e.Description,
                           Project = e.Project.Name,
                           Priority = e.Priority,
                           Status = e.StatusTask.Name
                       };
            return Ok(post);
        }

        // Search for a task by Id
        [ResponseType(typeof(Task))]
        public IHttpActionResult GetTask(int id)
        {
            Task task = db.Task.Find(id);
            if (task == null)
            {
                return NotFound();
            }

            var obj = new
            {
                ID = task.id,
                Name = task.Name,
                Description = task.Description,
                Project = task.Project.Name,
                Priority = task.Priority,
                Status = task.StatusTask.Name
            };

            return Ok(obj);
        }

        // Update the task information by the specified id
        [ResponseType(typeof(void))]
        public IHttpActionResult PutTask(int id, Task task)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != task.id)
            {
                return BadRequest();
            }

            db.Entry(task).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!TaskExists(id))
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

        // Add a new task
        [ResponseType(typeof(Task))]
        public IHttpActionResult PostTask(Task task)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Task.Add(task);
            db.SaveChanges();

            return CreatedAtRoute("DefaultApi", new { id = task.id }, task);
        }

        // Deleted a task 
        [ResponseType(typeof(Task))]
        public IHttpActionResult DeleteTask(int id)
        {
            Task task = db.Task.Find(id);
            if (task == null)
            {
                return NotFound();
            }

            db.Task.Remove(task);
            db.SaveChanges();

            return Ok(task);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool TaskExists(int id)
        {
            return db.Task.Count(e => e.id == id) > 0;
        }
    }
}