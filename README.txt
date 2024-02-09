The project and database upload are attached to the file. To get started, you will need to run a database script. 
After creating the database, you need to re-link the project and the database.
After following these instructions, you can make a request to the WebAPI

For more convenience of working with WebAPI, you need to use Postman.
There are two controllers in the project. These are controllers for performing operations with the Project and Task table.

URL for performing operations with the Project table

GET http://localhost:<Host number>/api/Projects/Get All - Getting a list of projects
GET http://localhost:<Host number>/api/Projects/{id} - Output of a specific project by its ID, and a list of its tasks.
PUT http://localhost:<Host number>/api/Projects - Updates of project information
POST http://localhost:<Host number>/api/Projects - Adding a new project
DELETE http://localhost:<Host number>/api/Projects/{id} - Deleting a project by the specified id

SORTING:
GET http://localhost:<Host number>/api/Projects/SortProjects/{name field} - sort projects by the specified column, in ascending order
GET http://localhost:<Host number>/api/Projects/SortProjects/{name field}?desc=desc - sort projects by the specified column, in descending order

FILTERING:


URL for performing operations with the Task table

GET http://localhost:<Host number>/api/Tasks/Get All - Getting the list of tasks and the name of the project
GET http://localhost:<Host number>/api/Tasks/{id} - Output of a specific task by its ID
PUT http://localhost:<Host number>/api/Tasks- Task information updates
POST http://localhost:<Host number>/api/Tasks- Adding a new task to the project
DELETE http://localhost:<Host number>/api/Tasks/{id} - Deleting a task by the specified id