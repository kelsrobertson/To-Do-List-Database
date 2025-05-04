import cherrypy
import pymysql

# Set up the MySQL connection
conn = pymysql.connect(
    host='localhost',      # Your MySQL host
    user='root',           # Your MySQL root user
    password='Kelsey2003!', # MySQL password
    database='to_do_list_db'  # The database name
)

cursor = conn.cursor()

# Function to get all users and their tasks from the database
def get_all_users_tasks():
	query = """
    	SELECT Users.username, Tasks.task_name, Tasks.status, Tasks.deadline
    	FROM Users
    	JOIN Tasks ON Users.user_id = Tasks.user_id;
	"""
	
	cursor.execute(query)
	result = cursor.fetchall()
	tasks = [{'user': row[0], 'task_name': row[1], 'status': row[2], 'deadline': row[3]} 
	for row in result]
	return tasks

# CherryPy-exposed function to serve the tasks list
@cherrypy.expose
def index():
	tasks = get_all_users_tasks()
	task_list = "<br>".join(f"User: {task['user']}, Task: {task['task_name']},Status: {task['status']}, Deadline: {task['deadline']}" for task in tasks)
	return f"<h1>User Tasks</h1><div>{task_list}</div>"

# Close the cursor and connection when the app is stopped
def close_resources():
	if cursor:
		cursor.close()
	if conn:
		conn.close()

# Start the CherryPy server
if __name__ == '__main__':
	cherrypy.engine.subscribe('exit', close_resources) # Ensure resources are closed on exit
	cherrypy.quickstart(index, '/', { # Use the index function directly
		'global': {
			'server.socket_host': '0.0.0.0', # Listen on all interfaces
			'server.socket_port': 8080, # Or your desired port
		}
	})
