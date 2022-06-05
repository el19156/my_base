##I want the following triggers:
##Before deleting employee, check that he does not have active project/supervision DONE
##Before deleting admin_by_org, check that nobody works on that project DONE
##να βαλω indexes

##cd ./Users/hasak/OneDrive/Desktop/my_base/my_enviroment
##./Scripts/activate
##$env:FLASK_APP = "app"
##./Scripts/flask run
##https://www.askpython.com/python-modules/flask/flask-mysql-database
##MRDbWcGBX5FtEC9

from flask import Flask,render_template, request, send_from_directory
from flask_mysqldb import MySQL
import mysql.connector

app = Flask(__name__)

app.config['MYSQL_HOST'] = '127.0.0.1'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'my_base'

connection = mysql.connector.connect(host='localhost',
                                     database='my_base',
                                     user='root',
                                     password='')

#Creating a connection cursor
#cur = my_base.connection.cursor()
cur = connection.cursor()
 
#Executing SQL Statements
cur.execute(''' USE my_base; ''')
#cur.execute(''' CREATE TABLE example (id INTERGER) ''')
#cur.execute(''' SET AUTOCOMMIT=0; ''')
#cur.execute(''' INSERT INTO project VALUES ('','δφλκλσδφ','2021-05-14', '2023-11-21', 123456);''')
#cur.execute(''' COMMIT''')
 
#Saving the Actions performed on the DB
#my_base.connection.commit()

#Closing the cursor
cur.close()

@app.route('/landing')
def landing():
    return render_template('landing.html')

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## INSERTION FORMS
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

@app.route('/researcher_form')
def researcher_form():
    return render_template('researcher_form.html')

@app.route('/organisation_form')
def organisation_form():
    return render_template('organisation_form.html')

@app.route('/project_form')
def project_form():
    return render_template('project_form.html')

@app.route('/program_form')
def program_form():
    return render_template('program_form.html')

@app.route('/field_form')
def field_form():
    return render_template('field_form.html')

@app.route('/executive_form')
def executive_form():
    return render_template('executive_form.html')

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## ACTUAL INSERTIONS
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@app.route('/researcher_insert', methods = ['POST', 'GET'])
def researcher_insert():
    if request.method == 'GET':
        return "GET is invalid in researcher insertion"
     
    if request.method == 'POST':
        name = request.form['name']
        surname = request.form['surname']
        birthdate = request.form['birthdate']
        gender = request.form['gender']
        cur = connection.cursor()
        cur.execute(''' INSERT INTO researcher (name, surname, birthdate, gender) VALUES(%s,%s,%s,%s)''',(name,surname,birthdate,gender))
        cur.execute(''' COMMIT''')
        cur.close()
        #return f"Done!!"
        return render_template('insertion_complete.html')

@app.route('/organisation_insert', methods = ['POST', 'GET'])
def organisation_insert():
    if request.method == 'GET':
        return "GET is invalid in organisation insertion"
     
    if request.method == 'POST':
        name = request.form['name']
        short_name = request.form['short_name']
        city = request.form['city']
        postal_code = request.form['postal_code']
        street = request.form['street']
        category = request.form['category']
        cur = connection.cursor()
        cur.execute(''' INSERT INTO organisation (name, short_name, city, postal_code, street, category) VALUES(%s,%s,%s,%s,%s,%s)''',((name, short_name, city, postal_code, street, category)))
        cur.execute(''' COMMIT''')
        cur.close()
        #return f"Done!!"
        return render_template('insertion_complete.html')

@app.route('/project_insert', methods = ['POST', 'GET'])
def project_insert():
    if request.method == 'GET':
        return "GET is invalid in project insertion"
     
    if request.method == 'POST':
        title = request.form['title']
        information = request.form['information']
        start = request.form['start']
        end = request.form['end']
        budget = request.form['budget']
        cur = connection.cursor()
        cur.execute(''' INSERT INTO project (title, information, start, end, budget) VALUES(%s,%s,%s,%s,%s)''',(title, information, start, end, budget))
        cur.execute(''' COMMIT''')
        cur.close()
        #return f"Done!!"
        return render_template('insertion_complete.html')

@app.route('/program_insert', methods = ['POST', 'GET'])
def program_insert():
    if request.method == 'GET':
        return "GET is invalid in program insertion"
     
    if request.method == 'POST':
        name = request.form['name']
        address = request.form['address']
        cur = connection.cursor()
        cur.execute(''' INSERT INTO program (name, address) VALUES(%s,%s)''',(name, address))
        cur.execute(''' COMMIT''')
        cur.close()
        #return f"Done!!"
        return render_template('insertion_complete.html')

@app.route('/field_insert', methods = ['POST', 'GET'])
def field_insert():
    if request.method == 'GET':
        return "GET is invalid in field insertion"
     
    if request.method == 'POST':
        name = request.form['name']
        cur = connection.cursor()
        cur.execute(''' INSERT INTO field (name) VALUES(%s)''',(name,))
        cur.execute(''' COMMIT''')
        cur.close()
        #return f"Done!!"
        return render_template('insertion_complete.html')

@app.route('/executive_insert', methods = ['POST', 'GET'])
def executive_insert():
    if request.method == 'GET':
        return "GET is invalid in executive insertion"
     
    if request.method == 'POST':
        name = request.form['name']
        surname = request.form['surname']
        cur = connection.cursor()
        cur.execute(''' INSERT INTO executive (name, surname) VALUES(%s,%s)''',(name, surname))
        cur.execute(''' COMMIT''')
        cur.close()
        #return f"Done!!"
        return render_template('insertion_complete.html')

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## SHOW SIMPLE TABLES
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

@app.route('/researcher_show')
def researcher_show():
    cur = connection.cursor()
    cur.execute(''' SELECT * FROM researcher ORDER BY name''')
    result = cur.fetchall()
    cur.close()
    contents = []
    contents1 = '''<!DOCTYPE html><html><head><style>
    table, th, td {border: 1px solid black;border-collapse: collapse;}</style>
    <meta charset="UTF-8"><meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <title>Show researchers</title></head><body>'''
    tbl = "<table><tr><td>ID</td><td>Name</td><td>Surname</td><td>Birthdate</td><td>Gender</td></tr>"
    contents.append(contents1)
    contents.append(tbl)
    for row in result:
        a = "<tr><td>%s</td>"%row[0]
        contents.append(a)
        b = "<td>%s</td>"%row[1]
        contents.append(b)
        c = "<td>%s</td>"%row[2]
        contents.append(c)
        d = "<td>%s</td>"%row[3]
        contents.append(d)
        e = "<td>%s</td></tr>"%row[4]
        contents.append(e)
    contents2 = "</table><button><a href='landing'>Back to landing</a></button></body></html>"
    contents.append(contents2)
    s = '\n'.join(contents)
    f = open("./templates/researcher_show.html", "w", encoding = "UTF-8")
    f.write(s)
    f.close()
    #return render_template('researcher_show.html')
    return send_from_directory('./templates','researcher_show.html')

@app.route('/organisation_show')
def organisation_show():
    cur = connection.cursor()
    cur.execute(''' SELECT * FROM organisation ORDER BY category''')
    result = cur.fetchall()
    cur.close()
    contents = []
    contents1 = '<!DOCTYPE html><html><head><style>table, th, td {border: 1px solid black;border-collapse: collapse;}</style><meta charset="UTF-8"><title>Show organisations</title></head><body>'
    tbl = "<table><tr><td>ID</td><td>Name</td><td>Short name</td><td>City</td><td>Postal code</td><td>Street</td><td>Category</td></tr>"
    contents.append(contents1)
    contents.append(tbl)
    for row in result:
        a = "<tr><td>%s</td>"%row[0]
        contents.append(a)
        b = "<td>%s</td>"%row[1]
        contents.append(b)
        c = "<td>%s</td>"%row[2]
        contents.append(c)
        d = "<td>%s</td>"%row[3]
        contents.append(d)
        e = "<td>%s</td>"%row[4]
        contents.append(e)
        e2 = "<td>%s</td>"%row[5]
        contents.append(e2)
        e4 = "<td>%s</td></tr>"%row[6]
        contents.append(e4)
    contents2 = "</table><button><a href='landing'>Back to landing</a></button></body></html>"
    contents.append(contents2)
    s = '\n'.join(contents)
    f = open("./templates/organisation_show.html", "w", encoding = "UTF-8")
    f.write(s)
    f.close()
    #return render_template('organisation_show.html')
    return send_from_directory('./templates','organisation_show.html')

@app.route('/project_show')
def project_show():
    cur = connection.cursor()
    cur.execute(''' SELECT * FROM project''')
    result = cur.fetchall()
    cur.close()
    contents = []
    contents1 = '<!DOCTYPE html><html><head><style>table, th, td {border: 1px solid black;border-collapse: collapse;}</style><meta charset="UTF-8"><title>Show projects</title></head><body>'
    tbl = "<table><tr><td>ID</td><td>Title</td><td>Information</td><td>Start</td><td>End</td><td>Budget</td></tr>"
    contents.append(contents1)
    contents.append(tbl)
    for row in result:
        a = "<tr><td>%s</td>"%row[0]
        contents.append(a)
        b = "<td>%s</td>"%row[1]
        contents.append(b)
        c = "<td>%s</td>"%row[2]
        contents.append(c)
        d = "<td>%s</td>"%row[3]
        contents.append(d)
        d2 = "<td>%s</td>"%row[4]
        contents.append(d2)
        e = "<td>%s</td></tr>"%row[5]
        contents.append(e)
    contents2 = "</table><button><a href='landing'>Back to landing</a></button></body></html>"
    contents.append(contents2)
    s = '\n'.join(contents)
    f = open("./templates/project_show.html", "w", encoding = "UTF-8")
    f.write(s)
    f.close()
    #return render_template('project_show.html')
    return send_from_directory('./templates','project_show.html')

@app.route('/program_show')
def program_show():
    cur = connection.cursor()
    cur.execute(''' SELECT * FROM program ORDER BY address''')
    result = cur.fetchall()
    contents = []
    contents1 = '<!DOCTYPE html><html><head><style>table, th, td {border: 1px solid black;border-collapse: collapse;}</style><meta charset="UTF-8"><title>Show programs</title></head><body>'
    tbl = "<table><tr><td>ID</td><td>Name</td><td>Address</td></tr>"
    contents.append(contents1)
    contents.append(tbl)
    for row in result:
        a = "<tr><td>%s</td>"%row[0]
        contents.append(a)
        b = "<td>%s</td>"%row[1]
        contents.append(b)
        c = "<td>%s</td></tr>"%row[2]
        contents.append(c)
    contents2 = "</table><button><a href='landing'>Back to landing</a></button></body></html>"
    contents.append(contents2)
    s = '\n'.join(contents)
    f = open("./templates/program_show.html", "w", encoding = "UTF-8")
    f.write(s)
    f.close()
    #return render_template('program_show.html')
    return send_from_directory('./templates','program_show.html')

@app.route('/field_show')
def field_show():
    cur = connection.cursor()
    cur.execute(''' SELECT * FROM field''')
    result = cur.fetchall()
    contents = []
    contents1 = '<!DOCTYPE html><html><head><style>table, th, td {border: 1px solid black;border-collapse: collapse;}</style><meta charset="UTF-8"><title>Show fields</title></head><body>'
    tbl = "<table><tr><td>Name</td></tr>"
    contents.append(contents1)
    contents.append(tbl)
    for row in result:
        a = "<tr><td>%s</td></tr>"%row[0]
        contents.append(a)
    contents2 = "</table><button><a href='landing'>Back to landing</a></button></body></html>"
    contents.append(contents2)
    s = '\n'.join(contents)
    f = open("./templates/field_show.html", "w", encoding = "UTF-8")
    f.write(s)
    f.close()
    #return render_template('field_show.html')
    return send_from_directory('./templates','field_show.html')

@app.route('/executive_show')
def executive_show():
    cur = connection.cursor()
    cur.execute(''' SELECT * FROM executive''')
    result = cur.fetchall()
    contents = []
    contents1 = '<!DOCTYPE html><html><head><style>table, th, td {border: 1px solid black;border-collapse: collapse;}</style><meta charset="UTF-8"><title>Show executives</title></head><body>'
    tbl = "<table><tr><td>ID</td><td>Name</td><td>Surname</td></tr>"
    contents.append(contents1)
    contents.append(tbl)
    for row in result:
        a = "<tr><td>%s</td>"%row[0]
        contents.append(a)
        b = "<td>%s</td>"%row[1]
        contents.append(b)
        c = "<td>%s</td></tr>"%row[2]
        contents.append(c)
    contents2 = "</table><button><a href='landing'>Back to landing</a></button></body></html>"
    contents.append(contents2)
    s = '\n'.join(contents)
    f = open("./templates/executive_show.html", "w", encoding = "UTF-8")
    f.write(s)
    f.close()
    #return render_template('executive_show.html')
    return send_from_directory('./templates','executive_show.html')

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## DELETE FORM
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

@app.route('/researcher_delete_form')
def researcher_delete_form():
    cur = connection.cursor()
    cur.execute(''' SELECT * FROM researcher''')
    researcher_list = cur.fetchall()
    cur.close()
    return render_template('researcher_delete_form.html',researcher_list=researcher_list)
    
@app.route('/organisation_delete_form')
def organisation_delete_form():
    cur = connection.cursor()
    cur.execute(''' SELECT * FROM organisation''')
    organisation_list = cur.fetchall()
    #print(organisation_list)
    cur.close()
    return render_template('organisation_delete_form.html',organisation_list=organisation_list)
    
@app.route('/project_delete_form')
def project_delete_form():
    cur = connection.cursor()
    cur.execute(''' SELECT * FROM project''')
    project_list = cur.fetchall()
    #print(project_list)
    cur.close()
    return render_template('project_delete_form.html',project_list=project_list)
    
@app.route('/program_delete_form')
def program_delete_form():
    cur = connection.cursor()
    cur.execute(''' SELECT * FROM program''')
    program_list = cur.fetchall()
    #print(program_list)
    cur.close()
    return render_template('program_delete_form.html',program_list=program_list)
    
@app.route('/field_delete_form')
def field_delete_form():
    cur = connection.cursor()
    cur.execute(''' SELECT * FROM field''')
    field_list = cur.fetchall()
    #print(field_list)
    cur.close()
    return render_template('field_delete_form.html',field_list=field_list)
    
@app.route('/executive_delete_form')
def executive_delete_form():
    cur = connection.cursor()
    cur.execute(''' SELECT * FROM executive''')
    executive_list = cur.fetchall()
    print(executive_list)
    cur.close()
    return render_template('executive_delete_form.html',executive_list=executive_list)
    
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## ACTUAL DELETIONS
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

@app.route('/researcher_delete', methods = ['POST', 'GET'])
def researcher_delete():
    if request.method == 'GET':
        return "GET is invalid in researcher delete"
     
    if request.method == 'POST':
        id = request.form['id']
        cur = connection.cursor()
        cur.execute(''' DELETE FROM researcher WHERE (id = %s)''',(id,))
        cur.execute(''' COMMIT''')
        cur.close()
        #return f"Done!!"
        return render_template('delete_complete.html')
        
@app.route('/organisation_delete', methods = ['POST', 'GET'])
def organisation_delete():
    if request.method == 'GET':
        return "GET is invalid in organisation delete"
     
    if request.method == 'POST':
        id = request.form['id']
        cur = connection.cursor()
        cur.execute(''' DELETE FROM organisation WHERE (id = %s)''',(id,))
        cur.execute(''' COMMIT''')
        cur.close()
        #return f"Done!!"
        return render_template('delete_complete.html')
        
@app.route('/project_delete', methods = ['POST', 'GET'])
def project_delete():
    if request.method == 'GET':
        return "GET is invalid in project delete"
     
    if request.method == 'POST':
        id = request.form['id']
        cur = connection.cursor()
        cur.execute(''' DELETE FROM project WHERE (id = %s)''',(id,))
        cur.execute(''' COMMIT''')
        cur.close()
        #return f"Done!!"
        return render_template('delete_complete.html')
        
@app.route('/program_delete', methods = ['POST', 'GET'])
def program_delete():
    if request.method == 'GET':
        return "GET is invalid in program delete"
     
    if request.method == 'POST':
        id = request.form['id']
        cur = connection.cursor()
        cur.execute(''' DELETE FROM program WHERE (id = %s)''',(id,))
        cur.execute(''' COMMIT''')
        cur.close()
        #return f"Done!!"
        return render_template('delete_complete.html')
        
@app.route('/field_delete', methods = ['POST', 'GET'])
def field_delete():
    if request.method == 'GET':
        return "GET is invalid in field delete"
     
    if request.method == 'POST':
        name = request.form['name']
        cur = connection.cursor()
        cur.execute(''' DELETE FROM field WHERE (name = %s)''',(name,))
        cur.execute(''' COMMIT''')
        cur.close()
        #return f"Done!!"
        return render_template('delete_complete.html')

@app.route('/executive_delete', methods = ['POST', 'GET'])
def executive_delete():
    if request.method == 'GET':
        return "GET is invalid in executive delete"
     
    if request.method == 'POST':
        id = request.form['id']
        cur = connection.cursor()
        cur.execute(''' DELETE FROM executive WHERE (id = %s)''',(id,))
        cur.execute(''' COMMIT''')
        cur.close()
        #return f"Done!!"
        return render_template('delete_complete.html')
        
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## INSERTION FORMS FOR STRANGE TABLES
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

@app.route('/employee_form')
def employee_form():
    cur = connection.cursor()
    cur.execute(''' SELECT * FROM researcher
    WHERE (researcher.id NOT IN
    (SELECT employee.researcher_id FROM employee))
    ORDER BY researcher.name''')
    researcher_list = cur.fetchall()
    cur.execute(''' SELECT * FROM organisation''')
    organisation_list = cur.fetchall()
    cur.close()
    return render_template('employee_form.html',researcher_list=researcher_list,organisation_list=organisation_list)

@app.route('/admin_by_exec_form')
def admin_by_exec_form():
    cur = connection.cursor()
    cur.execute(''' SELECT * FROM (project AS p)
    WHERE (p.id NOT IN
    (SELECT admin_by_exec.project_id FROM admin_by_exec))
    ORDER BY p.id''')
    project_list = cur.fetchall()
    cur.execute(''' SELECT * FROM executive''')
    executive_list = cur.fetchall()
    cur.close()
    return render_template('admin_by_exec_form.html',project_list=project_list,executive_list=executive_list)

@app.route('/admin_by_org_form')
def admin_by_org_form():
    cur = connection.cursor()
    cur.execute(''' SELECT * FROM (project AS p)
    WHERE (p.id NOT IN
    (SELECT admin_by_org.project_id FROM admin_by_org))
    ORDER BY p.id''')
    project_list = cur.fetchall()
    cur.execute(''' SELECT * FROM organisation ORDER BY name''')
    organisation_list = cur.fetchall()
    cur.close()
    return render_template('admin_by_org_form.html',project_list=project_list,organisation_list=organisation_list)

@app.route('/deliverable_form')
def deliverable_form():
    cur = connection.cursor()
    cur.execute(''' SELECT * FROM project''')
    project_list = cur.fetchall()
    cur.close()
    return render_template('deliverable_form.html',project_list=project_list)

@app.route('/works_on_proj_form')
def works_on_proj_form():
    cur = connection.cursor()
    cur.execute(''' SELECT * FROM researcher''')
    researcher_list = cur.fetchall()
    cur.execute(''' SELECT * FROM project''')
    project_list = cur.fetchall()
    cur.close()
    return render_template('works_on_proj_form.html',researcher_list=researcher_list,project_list=project_list)

@app.route('/financing_form')
def financing_form():
    cur = connection.cursor()
    cur.execute(''' SELECT * FROM project''')
    project_list = cur.fetchall()
    cur.execute(''' SELECT * FROM program''')
    program_list = cur.fetchall()
    cur.close()
    return render_template('financing_form.html',project_list=project_list,program_list=program_list)

@app.route('/organisation_phone_form')
def organisation_phone_form():
    cur = connection.cursor()
    cur.execute(''' SELECT * FROM organisation''')
    organisation_list = cur.fetchall()
    cur.close()
    return render_template('organisation_phone_form.html',organisation_list=organisation_list)

@app.route('/grading_form')
def grading_form():
    cur = connection.cursor()
    cur.execute(''' SELECT * FROM researcher''')
    researcher_list = cur.fetchall()
    cur.execute(''' SELECT * FROM project''')
    project_list = cur.fetchall()
    cur.close()
    return render_template('grading_form.html',researcher_list=researcher_list,project_list=project_list)

@app.route('/project_field_form')
def project_field_form():
    cur = connection.cursor()
    cur.execute(''' SELECT * FROM field''')
    field_list = cur.fetchall()
    cur.execute(''' SELECT * FROM project''')
    project_list = cur.fetchall()
    cur.close()
    return render_template('project_field_form.html',project_list=project_list,field_list=field_list,)

@app.route('/supervision_form')
def supervision_form():
    cur = connection.cursor()
    cur.execute(''' SELECT * FROM researcher''')
    researcher_list = cur.fetchall()
    cur.execute(''' SELECT * FROM project''')
    project_list = cur.fetchall()
    cur.close()
    return render_template('supervision_form.html',researcher_list=researcher_list,project_list=project_list)

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## ACTUAL INSERTIONS FOR STRANGE TABLES
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

@app.route('/employee_insert', methods = ['POST', 'GET'])
def employee_insert():
    if request.method == 'GET':
        return "GET is invalid in employee insertion"
     
    if request.method == 'POST':
        researcher_id = request.form['researcher_id']
        organisation_id = request.form['organisation_id']
        date = request.form['date']
        cur = connection.cursor()
        cur.execute(''' INSERT INTO employee (researcher_id, organisation_id, date) VALUES(%s,%s,%s)''',(researcher_id,organisation_id,date))
        cur.execute(''' COMMIT''')
        cur.close()
        #return f"Done!!"
        return render_template('insertion_complete.html')
        
@app.route('/admin_by_exec_insert', methods = ['POST', 'GET'])
def admin_by_exec_insert():
    if request.method == 'GET':
        return "GET is invalid in admin_by_exec insertion"
     
    if request.method == 'POST':
        project_id = request.form['project_id']
        exec_id = request.form['exec_id']
        cur = connection.cursor()
        cur.execute(''' INSERT INTO admin_by_exec (project_id, exec_id) VALUES(%s,%s)''',(project_id,exec_id))
        cur.execute(''' COMMIT''')
        cur.close()
        #return f"Done!!"
        return render_template('insertion_complete.html')
        
@app.route('/admin_by_org_insert', methods = ['POST', 'GET'])
def admin_by_org_insert():
    if request.method == 'GET':
        return "GET is invalid in admin_by_org insertion"
     
    if request.method == 'POST':
        project_id = request.form['project_id']
        organisation_id = request.form['organisation_id']
        cur = connection.cursor()
        cur.execute(''' INSERT INTO admin_by_org (project_id, organisation_id) VALUES(%s,%s)''',(project_id,organisation_id))
        cur.execute(''' COMMIT''')
        cur.close()
        #return f"Done!!"
        return render_template('insertion_complete.html')

@app.route('/deliverable_insert', methods = ['POST', 'GET'])
def deliverable_insert():
    if request.method == 'GET':
        return "GET is invalid in deliverable insertion"
     
    if request.method == 'POST':
        project_id = request.form['project_id']
        name = request.form['name']
        deadline = request.form['deadline']
        cur = connection.cursor()
        #I must find start and end of project, and check if deadline is between
        #start = cur.execute(''' SELECT start FROM project WHERE (id = "%s")''',project_id)
        #end = cur.execute(''' SELECT end FROM project WHERE (id = "%s")''',project_id)
        #if (
        cur.execute(''' INSERT INTO deliverable (project_id, name, deadline) VALUES(%s,%s,%s)''',(project_id,name,deadline))
        cur.execute(''' COMMIT''')
        cur.close()
        #return f"Done!!"
        return render_template('insertion_complete.html')

@app.route('/works_on_proj_insert', methods = ['POST', 'GET'])
def works_on_proj_insert():
    if request.method == 'GET':
        return "GET is invalid in works_on_proj insertion"
     
    if request.method == 'POST':
        researcher_id = request.form['researcher_id']
        project_id = request.form['project_id']
        cur = connection.cursor()
        cur.execute(''' INSERT INTO works_on_proj (project_id, researcher_id) VALUES(%s,%s)''',(project_id,researcher_id))
        cur.execute(''' COMMIT''')
        cur.close()
        #return f"Done!!"
        return render_template('insertion_complete.html')

@app.route('/financing_insert', methods = ['POST', 'GET'])
def financing_insert():
    if request.method == 'GET':
        return "GET is invalid in financing insertion"
     
    if request.method == 'POST':
        project_id = request.form['project_id']
        program_id = request.form['program_id']
        cur = connection.cursor()
        cur.execute(''' INSERT INTO financing (project_id, program_id) VALUES(%s,%s)''',(project_id,program_id))
        cur.execute(''' COMMIT''')
        cur.close()
        #return f"Done!!"
        return render_template('insertion_complete.html')

@app.route('/organisation_phone_insert', methods = ['POST', 'GET'])
def organisation_phone_insert():
    if request.method == 'GET':
        return "GET is invalid in organisation_phone insertion"
     
    if request.method == 'POST':
        organisation_id = request.form['organisation_id']
        telephone_number = request.form['phone_number']
        cur = connection.cursor()
        cur.execute(''' INSERT INTO organisation_phone (organisation_id, telephone_number) VALUES(%s,%s)''',(organisation_id, telephone_number))
        cur.execute(''' COMMIT''')
        cur.close()
        #return f"Done!!"
        return render_template('insertion_complete.html')

@app.route('/grading_insert', methods = ['POST', 'GET'])
def grading_insert():
    if request.method == 'GET':
        return "GET is invalid in grading insertion"
     
    if request.method == 'POST':
        researcher_id = request.form['researcher_id']
        project_id = request.form['project_id']
        grade = request.form['grade']
        date = request.form['date']
        cur = connection.cursor()
        cur.execute(''' INSERT INTO grading (project_id, grade, date, researcher_id) VALUES(%s,%s,%s,%s)''',(project_id, grade, date, researcher_id))
        cur.execute(''' COMMIT''')
        cur.close()
        #return f"Done!!"
        return render_template('insertion_complete.html')

@app.route('/project_field_insert', methods = ['POST', 'GET'])
def project_field_insert():
    if request.method == 'GET':
        return "GET is invalid in project_field insertion"
     
    if request.method == 'POST':
        project_id = request.form['project_id']
        field_name = request.form['field_name']
        cur = connection.cursor()
        cur.execute(''' INSERT INTO project_field (project_id, field_name) VALUES(%s,%s)''',(project_id, field_name))
        cur.execute(''' COMMIT''')
        cur.close()
        #return f"Done!!"
        return render_template('insertion_complete.html')

@app.route('/supervision_insert', methods = ['POST', 'GET'])
def supervision_insert():
    if request.method == 'GET':
        return "GET is invalid in supervision insertion"
     
    if request.method == 'POST':
        researcher_id = request.form['researcher_id']
        project_id = request.form['project_id']
        cur = connection.cursor()
        cur.execute(''' INSERT INTO supervision (project_id, researcher_id) VALUES(%s,%s)''',(project_id,researcher_id))
        cur.execute(''' COMMIT''')
        cur.close()
        #return f"Done!!"
        return render_template('insertion_complete.html')

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## SHOW STRANGE TABLES
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

@app.route('/employee_show')
def employee_show():
    cur = connection.cursor()
    cur.execute(''' SELECT organisation.id, organisation.name, employee.researcher_id, researcher.name, researcher.surname, employee.date
    FROM employee INNER JOIN organisation INNER JOIN researcher
    WHERE (employee.organisation_id = organisation.id AND employee.researcher_id = researcher.id)''')
    result = cur.fetchall()
    cur.close()
    contents = []
    contents1 = '<!DOCTYPE html><html><head><style>table, th, td {border: 1px solid black;border-collapse: collapse;}</style><meta charset="UTF-8"><title>Show employees</title></head><body>'
    tbl = "<table><tr><td>Org ID</td><td>Org name</td><td>Res ID</td><td>Res name</td><td>Res surname</td><td>Start</td></tr>"
    contents.append(contents1)
    contents.append(tbl)
    for row in result:
        a = "<tr><td>%s</td>"%row[0]
        contents.append(a)
        b = "<td>%s</td>"%row[1]
        contents.append(b)
        c = "<td>%s</td>"%row[2]
        contents.append(c)
        d = "<td>%s</td>"%row[3]
        contents.append(d)
        e = "<td>%s</td>"%row[4]
        contents.append(e)
        e5 = "<td>%s</td>"%row[5]
        contents.append(e5)
    contents2 = "</table><button><a href='landing'>Back to landing</a></button></body></html>"
    contents.append(contents2)
    s = '\n'.join(contents)
    f = open("./templates/employee_show.html", "w", encoding = "UTF-8")
    f.write(s)
    f.close()
    #return render_template('employee_show.html')
    return send_from_directory('./templates','employee_show.html')

@app.route('/admin_by_exec_show')
def admin_by_exec_show():
    cur = connection.cursor()
    cur.execute(''' SELECT project.id, project.title, admin_by_exec.exec_id, executive.name, executive.surname
    FROM admin_by_exec INNER JOIN project INNER JOIN executive
    WHERE (admin_by_exec.project_id = project.id AND admin_by_exec.exec_id = executive.id)''')
    result = cur.fetchall()
    cur.close()
    contents = []
    contents1 = '<!DOCTYPE html><html><head><style>table, th, td {border: 1px solid black;border-collapse: collapse;}</style><meta charset="UTF-8"><title>Show admin_by_execs</title></head><body>'
    tbl = "<table><tr><td>Proj ID</td><td>Proj title</td><td>Exec ID</td><td>Exec name</td><td>Exec surname</td></tr>"
    contents.append(contents1)
    contents.append(tbl)
    for row in result:
        a = "<tr><td>%s</td>"%row[0]
        contents.append(a)
        b = "<td>%s</td>"%row[1]
        contents.append(b)
        c = "<td>%s</td>"%row[2]
        contents.append(c)
        d = "<td>%s</td>"%row[3]
        contents.append(d)
        e = "<td>%s</td>"%row[4]
        contents.append(e)
    contents2 = "</table><button><a href='landing'>Back to landing</a></button></body></html>"
    contents.append(contents2)
    s = '\n'.join(contents)
    f = open("./templates/admin_by_exec_show.html", "w", encoding = "UTF-8")
    f.write(s)
    f.close()
    #return render_template('admin_by_exec_show.html')
    return send_from_directory('./templates','admin_by_exec_show.html')

@app.route('/admin_by_org_show')
def admin_by_org_show():
    cur = connection.cursor()
    cur.execute(''' SELECT project.id, project.title, admin_by_org.organisation_id, organisation.name
    FROM admin_by_org INNER JOIN project INNER JOIN organisation
    WHERE (admin_by_org.project_id = project.id AND admin_by_org.organisation_id = organisation.id)''')
    result = cur.fetchall()
    cur.close()
    contents = []
    contents1 = '<!DOCTYPE html><html><head><style>table, th, td {border: 1px solid black;border-collapse: collapse;}</style><meta charset="UTF-8"><title>Show admin_by_orgs</title></head><body>'
    tbl = "<table><tr><td>Proj ID</td><td>Proj title</td><td>Org ID</td><td>Org name</td></tr>"
    contents.append(contents1)
    contents.append(tbl)
    for row in result:
        a = "<tr><td>%s</td>"%row[0]
        contents.append(a)
        b = "<td>%s</td>"%row[1]
        contents.append(b)
        c = "<td>%s</td>"%row[2]
        contents.append(c)
        d = "<td>%s</td>"%row[3]
        contents.append(d)
    contents2 = "</table><button><a href='landing'>Back to landing</a></button></body></html>"
    contents.append(contents2)
    s = '\n'.join(contents)
    f = open("./templates/admin_by_org_show.html", "w", encoding = "UTF-8")
    f.write(s)
    f.close()
    #return render_template('admin_by_org_show.html')
    return send_from_directory('./templates','admin_by_org_show.html')

@app.route('/deliverable_show')
def deliverable_show():
    cur = connection.cursor()
    cur.execute(''' SELECT project.id, project.title, deliverable.name, deliverable.deadline
    FROM deliverable INNER JOIN project
    WHERE (deliverable.project_id = project.id)''')
    result = cur.fetchall()
    cur.close()
    contents = []
    contents1 = '<!DOCTYPE html><html><head><style>table, th, td {border: 1px solid black;border-collapse: collapse;}</style><meta charset="UTF-8"><title>Show deliverables</title></head><body>'
    tbl = "<table><tr><td>Proj ID</td><td>Proj title</td><td>Deliv name</td><td>Deadline</td></tr>"
    contents.append(contents1)
    contents.append(tbl)
    for row in result:
        a = "<tr><td>%s</td>"%row[0]
        contents.append(a)
        b = "<td>%s</td>"%row[1]
        contents.append(b)
        c = "<td>%s</td>"%row[2]
        contents.append(c)
        d = "<td>%s</td>"%row[3]
        contents.append(d)
    contents2 = "</table><button><a href='landing'>Back to landing</a></button></body></html>"
    contents.append(contents2)
    s = '\n'.join(contents)
    f = open("./templates/deliverable_show.html", "w", encoding = "UTF-8")
    f.write(s)
    f.close()
    #return render_template('deliverable_show.html')
    return send_from_directory('./templates','deliverable_show.html')

@app.route('/financing_show')
def financing_show():
    cur = connection.cursor()
    cur.execute(''' SELECT program.id, program.name, financing.project_id, project.title
    FROM financing INNER JOIN program INNER JOIN project
    WHERE (financing.program_id = program.id AND financing.project_id = project.id)''')
    result = cur.fetchall()
    cur.close()
    contents = []
    contents1 = '<!DOCTYPE html><html><head><style>table, th, td {border: 1px solid black;border-collapse: collapse;}</style><meta charset="UTF-8"><title>Show financings</title></head><body>'
    tbl = "<table><tr><td>Prog ID</td><td>Prog name</td><td>Proj ID</td><td>Proj name</td></tr>"
    contents.append(contents1)
    contents.append(tbl)
    for row in result:
        a = "<tr><td>%s</td>"%row[0]
        contents.append(a)
        b = "<td>%s</td>"%row[1]
        contents.append(b)
        c = "<td>%s</td>"%row[2]
        contents.append(c)
        d = "<td>%s</td>"%row[3]
        contents.append(d)
    contents2 = "</table><button><a href='landing'>Back to landing</a></button></body></html>"
    contents.append(contents2)
    s = '\n'.join(contents)
    f = open("./templates/financing_show.html", "w", encoding = "UTF-8")
    f.write(s)
    f.close()
    #return render_template('financing_show.html')
    return send_from_directory('./templates','financing_show.html')

@app.route('/works_on_proj_show')
def works_on_proj_show():
    cur = connection.cursor()
    cur.execute(''' SELECT project.id, project.title, works_on_proj.researcher_id, researcher.name, researcher.surname
    FROM works_on_proj INNER JOIN project INNER JOIN researcher
    WHERE (works_on_proj.project_id = project.id AND works_on_proj.researcher_id = researcher.id)''')
    result = cur.fetchall()
    cur.close()
    contents = []
    contents1 = '<!DOCTYPE html><html><head><style>table, th, td {border: 1px solid black;border-collapse: collapse;}</style><meta charset="UTF-8"><title>Show works_on_projs</title></head><body>'
    tbl = "<table><tr><td>Proj ID</td><td>Proj title</td><td>Res ID</td><td>Res name</td><td>Res surname</td></tr>"
    contents.append(contents1)
    contents.append(tbl)
    for row in result:
        a = "<tr><td>%s</td>"%row[0]
        contents.append(a)
        b = "<td>%s</td>"%row[1]
        contents.append(b)
        c = "<td>%s</td>"%row[2]
        contents.append(c)
        d = "<td>%s</td>"%row[3]
        contents.append(d)
        e = "<td>%s</td>"%row[4]
        contents.append(e)
    contents2 = "</table><button><a href='landing'>Back to landing</a></button></body></html>"
    contents.append(contents2)
    s = '\n'.join(contents)
    f = open("./templates/works_on_proj_show.html", "w", encoding = "UTF-8")
    f.write(s)
    f.close()
    #return render_template('works_on_proj_show.html')
    return send_from_directory('./templates','works_on_proj_show.html')

@app.route('/organisation_phone_show')
def organisation_phone_show():
    cur = connection.cursor()
    cur.execute(''' SELECT organisation.id, organisation.name, organisation_phone.telephone_number
    FROM organisation_phone INNER JOIN organisation
    WHERE (organisation_phone.organisation_id = organisation.id)''')
    result = cur.fetchall()
    cur.close()
    contents = []
    contents1 = '<!DOCTYPE html><html><head><style>table, th, td {border: 1px solid black;border-collapse: collapse;}</style><meta charset="UTF-8"><title>Show organisation_phones</title></head><body>'
    tbl = "<table><tr><td>Org ID</td><td>Org name</td><td>Telephone</td></tr>"
    contents.append(contents1)
    contents.append(tbl)
    for row in result:
        a = "<tr><td>%s</td>"%row[0]
        contents.append(a)
        b = "<td>%s</td>"%row[1]
        contents.append(b)
        c = "<td>%s</td>"%row[2]
        contents.append(c)
    contents2 = "</table><button><a href='landing'>Back to landing</a></button></body></html>"
    contents.append(contents2)
    s = '\n'.join(contents)
    f = open("./templates/organisation_phone_show.html", "w", encoding = "UTF-8")
    f.write(s)
    f.close()
    #return render_template('organisation_phone_show.html')
    return send_from_directory('./templates','organisation_phone_show.html')

@app.route('/grading_show')
def grading_show():
    cur = connection.cursor()
    cur.execute(''' SELECT grading.project_id, project.title, grading.grade, grading.date,
    researcher.id, researcher.name, researcher.surname
    FROM grading INNER JOIN project INNER JOIN researcher
    WHERE (grading.researcher_id = researcher.id AND grading.project_id = project.id)''')
    result = cur.fetchall()
    cur.close()
    contents = []
    contents1 = '<!DOCTYPE html><html><head><style>table, th, td {border: 1px solid black;border-collapse: collapse;}</style><meta charset="UTF-8"><title>Show gradings</title></head><body>'
    tbl = "<table><tr><td>Proj ID</td><td>Proj title</td><td>Grade</td><td>Grading date</td><td>Grader ID</td><td>Grader name</td><td>Grader surname</td></tr>"
    contents.append(contents1)
    contents.append(tbl)
    for row in result:
        a = "<tr><td>%s</td>"%row[0]
        contents.append(a)
        b = "<td>%s</td>"%row[1]
        contents.append(b)
        c = "<td>%s</td>"%row[2]
        contents.append(c)
        d = "<td>%s</td>"%row[3]
        contents.append(d)
        e = "<td>%s</td>"%row[4]
        contents.append(e)
        e5 = "<td>%s</td>"%row[5]
        contents.append(e5)
        e6 = "<td>%s</td>"%row[6]
        contents.append(e6)
    contents2 = "</table><button><a href='landing'>Back to landing</a></button></body></html>"
    contents.append(contents2)
    s = '\n'.join(contents)
    f = open("./templates/grading_show.html", "w", encoding = "UTF-8")
    f.write(s)
    f.close()
    #return render_template('employee_show.html')
    return send_from_directory('./templates','grading_show.html')

@app.route('/project_field_show')
def project_field_show():
    cur = connection.cursor()
    cur.execute(''' SELECT project.id, project.title, project_field.field_name
    FROM project_field INNER JOIN project
    WHERE (project_field.project_id = project.id)''')
    result = cur.fetchall()
    cur.close()
    contents = []
    contents1 = '<!DOCTYPE html><html><head><style>table, th, td {border: 1px solid black;border-collapse: collapse;}</style><meta charset="UTF-8"><title>Show project_fields</title></head><body>'
    tbl = "<table><tr><td>Proj ID</td><td>Proj title</td><td>Field</td></tr>"
    contents.append(contents1)
    contents.append(tbl)
    for row in result:
        a = "<tr><td>%s</td>"%row[0]
        contents.append(a)
        b = "<td>%s</td>"%row[1]
        contents.append(b)
        c = "<td>%s</td>"%row[2]
        contents.append(c)
    contents2 = "</table><button><a href='landing'>Back to landing</a></button></body></html>"
    contents.append(contents2)
    s = '\n'.join(contents)
    f = open("./templates/project_field_show.html", "w", encoding = "UTF-8")
    f.write(s)
    f.close()
    #return render_template('project_field_show.html')
    return send_from_directory('./templates','project_field_show.html')

@app.route('/supervision_show')
def supervision_show():
    cur = connection.cursor()
    cur.execute(''' SELECT project.id, project.title, supervision.researcher_id, researcher.name, researcher.surname
    FROM supervision INNER JOIN project INNER JOIN researcher
    WHERE (supervision.project_id = project.id AND supervision.researcher_id = researcher.id)''')
    result = cur.fetchall()
    cur.close()
    contents = []
    contents1 = '<!DOCTYPE html><html><head><style>table, th, td {border: 1px solid black;border-collapse: collapse;}</style><meta charset="UTF-8"><title>Show supervisions</title></head><body>'
    tbl = "<table><tr><td>Proj ID</td><td>Proj title</td><td>Res ID</td><td>Res name</td><td>Res surname</td></tr>"
    contents.append(contents1)
    contents.append(tbl)
    for row in result:
        a = "<tr><td>%s</td>"%row[0]
        contents.append(a)
        b = "<td>%s</td>"%row[1]
        contents.append(b)
        c = "<td>%s</td>"%row[2]
        contents.append(c)
        d = "<td>%s</td>"%row[3]
        contents.append(d)
        e = "<td>%s</td>"%row[4]
        contents.append(e)
    contents2 = "</table><button><a href='landing'>Back to landing</a></button></body></html>"
    contents.append(contents2)
    s = '\n'.join(contents)
    f = open("./templates/supervision_show.html", "w", encoding = "UTF-8")
    f.write(s)
    f.close()
    #return render_template('supervision_show.html')
    return send_from_directory('./templates','supervision_show.html')

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## DELETE FORM FOR STRANGE TABLES
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

@app.route('/employee_delete_form')
def employee_delete_form():
    cur = connection.cursor()
    cur.execute(''' SELECT employee.researcher_id, researcher.name, researcher.surname,
    employee.organisation_id, organisation.name
    FROM employee INNER JOIN researcher INNER JOIN  organisation
    WHERE (employee.researcher_id = researcher.id AND
    employee.organisation_id = organisation.id)
    ORDER BY organisation_id''')
    employee_list = cur.fetchall()
    cur.close()
    return render_template('employee_delete_form.html',employee_list=employee_list)

@app.route('/works_on_proj_delete_form')
def works_on_proj_delete_form():
    cur = connection.cursor()
    cur.execute(''' SELECT w.project_id, project.title, w.researcher_id,
    researcher.name, researcher.surname FROM
    (works_on_proj AS w) INNER JOIN project INNER JOIN researcher
    WHERE (w.researcher_id = researcher.id AND w.project_id = project.id)
    ORDER BY project.title''')
    works_on_proj_list = cur.fetchall()
    cur.close()
    return render_template('works_on_proj_delete_form.html',works_on_proj_list=works_on_proj_list)

@app.route('/admin_by_exec_delete_form')
def admin_by_exec_delete_form():
    cur = connection.cursor()
    cur.execute(''' SELECT admin_by_exec.exec_id, executive.name, executive.surname,
    admin_by_exec.project_id, project.title
    FROM admin_by_exec INNER JOIN executive INNER JOIN project
    WHERE (admin_by_exec.exec_id = executive.id AND
    admin_by_exec.project_id = project.id)
    ORDER BY executive.name''')
    admin_by_exec_list = cur.fetchall()
    cur.close()
    return render_template('admin_by_exec_delete_form.html',admin_by_exec_list=admin_by_exec_list)

@app.route('/admin_by_org_delete_form')
def admin_by_org_delete_form():
    cur = connection.cursor()
    cur.execute(''' SELECT admin_by_org.project_id, project.title,
    admin_by_org.organisation_id, organisation.name
    FROM admin_by_org INNER JOIN organisation INNER JOIN project
    WHERE (admin_by_org.organisation_id = organisation.id AND
    admin_by_org.project_id = project.id)
    ORDER BY organisation.name''')
    admin_by_org_list = cur.fetchall()
    cur.close()
    return render_template('admin_by_org_delete_form.html',admin_by_org_list=admin_by_org_list)

@app.route('/deliverable_delete_form')
def deliverable_delete_form():
    cur = connection.cursor()
    cur.execute(''' SELECT project.id, project.title, deliverable.name, deliverable.deadline
    FROM deliverable INNER JOIN project
    WHERE (deliverable.project_id = project.id)
    ORDER BY project.id''')
    deliverable_list = cur.fetchall()
    cur.close()
    return render_template('deliverable_delete_form.html',deliverable_list=deliverable_list)

@app.route('/supervision_delete_form')
def supervision_delete_form():
    cur = connection.cursor()
    cur.execute(''' SELECT s.project_id, p.title, r.id, r.name, r.surname
    FROM (supervision AS s) INNER JOIN (researcher AS r) INNER JOIN  (project as p)
    WHERE (s.researcher_id = r.id AND
    s.project_id = p.id)
    ORDER BY project_id''')
    supervision_list = cur.fetchall()
    cur.close()
    return render_template('supervision_delete_form.html',supervision_list=supervision_list)

@app.route('/financing_delete_form')
def financing_delete_form():
    cur = connection.cursor()
    cur.execute(''' SELECT f.project_id, p.title, program.id, program.name
    FROM (financing AS f) INNER JOIN (program) INNER JOIN  (project as p)
    WHERE (f.program_id = program.id AND
    f.project_id = p.id)
    ORDER BY project_id''')
    financing_list = cur.fetchall()
    cur.close()
    return render_template('financing_delete_form.html',financing_list=financing_list)

@app.route('/organisation_phone_delete_form')
def organisation_phone_delete_form():
    cur = connection.cursor()
    cur.execute(''' SELECT organisation_phone.organisation_id, organisation.name, organisation_phone.telephone_number
    FROM organisation_phone INNER JOIN organisation
    WHERE (organisation_phone.organisation_id = organisation.id)
    ORDER BY organisation_id''')
    organisation_phone_list = cur.fetchall()
    cur.close()
    return render_template('organisation_phone_delete_form.html',organisation_phone_list=organisation_phone_list)

@app.route('/grading_delete_form')
def grading_delete_form():
    cur = connection.cursor()
    cur.execute(''' SELECT grading.project_id, project.title, grading.grade, grading.date,
    researcher.id, researcher.name, researcher.surname
    FROM grading INNER JOIN project INNER JOIN researcher
    WHERE (grading.researcher_id = researcher.id AND grading.project_id = project.id)''')
    grading_list = cur.fetchall()
    cur.close()
    return render_template('grading_delete_form.html',grading_list=grading_list)

@app.route('/project_field_delete_form')
def project_field_delete_form():
    cur = connection.cursor()
    cur.execute(''' SELECT project.id, project.title, project_field.field_name
    FROM project_field INNER JOIN project
    WHERE (project_field.project_id = project.id)''')
    project_field_list = cur.fetchall()
    cur.close()
    return render_template('project_field_delete_form.html',project_field_list=project_field_list)

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## ACTUAL DELETIONS FOR STRANGE TABLES
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

@app.route('/employee_delete', methods = ['POST', 'GET'])
def employee_delete():
    if request.method == 'GET':
        return "GET is invalid in employee delete"
     
    if request.method == 'POST':
        id = request.form['id']
        cur = connection.cursor()
        cur.execute(''' DELETE FROM employee WHERE (researcher_id = %s)''',(id,))
        cur.execute(''' COMMIT''')
        cur.close()
        #return f"Done!!"
        return render_template('delete_complete.html')

@app.route('/admin_by_exec_delete', methods = ['POST', 'GET'])
def admin_by_exec_delete():
    if request.method == 'GET':
        return "GET is invalid in admin_by_exec delete"
     
    if request.method == 'POST':
        id = request.form['id']
        cur = connection.cursor()
        cur.execute(''' DELETE FROM admin_by_exec WHERE (project_id = %s)''',(id,))
        cur.execute(''' COMMIT''')
        cur.close()
        #return f"Done!!"
        return render_template('delete_complete.html')

@app.route('/admin_by_org_delete', methods = ['POST', 'GET'])
def admin_by_org_delete():
    if request.method == 'GET':
        return "GET is invalid in admin_by_org delete"
     
    if request.method == 'POST':
        id = request.form['id']
        cur = connection.cursor()
        cur.execute(''' DELETE FROM admin_by_org WHERE (project_id = %s)''',(id,))
        cur.execute(''' COMMIT''')
        cur.close()
        #return f"Done!!"
        return render_template('delete_complete.html')

@app.route('/deliverable_delete', methods = ['POST', 'GET'])
def deliverable_delete():
    if request.method == 'GET':
        return "GET is invalid in deliverable delete"
     
    if request.method == 'POST':
        name = request.form['name']
        id = request.form['id']
        cur = connection.cursor()
        cur.execute(''' DELETE FROM deliverable
        WHERE (project_id = %s AND name = %s)''',(id, name))
        cur.execute(''' COMMIT''')
        cur.close()
        #return f"Done!!"
        return render_template('delete_complete.html')

@app.route('/works_on_proj_delete', methods = ['POST', 'GET'])
def works_on_proj_delete():
    if request.method == 'GET':
        return "GET is invalid in works_on_proj delete"
     
    if request.method == 'POST':
        project_id = request.form['project_id']
        researcher_id = request.form['researcher_id'] 
        cur = connection.cursor()
        cur.execute(''' DELETE FROM works_on_proj WHERE (researcher_id = %s
        AND project_id = %s)''',(researcher_id,project_id))
        cur.execute(''' COMMIT''')
        cur.close()
        #return f"Done!!"
        return render_template('delete_complete.html')

@app.route('/supervision_delete', methods = ['POST', 'GET'])
def supervision_delete():
    if request.method == 'GET':
        return "GET is invalid in supervision delete"
     
    if request.method == 'POST':
        id = request.form['id']
        cur = connection.cursor()
        cur.execute(''' DELETE FROM supervision WHERE (project_id = %s)''',(id,))
        cur.execute(''' COMMIT''')
        cur.close()
        #return f"Done!!"
        return render_template('delete_complete.html')

@app.route('/financing_delete', methods = ['POST', 'GET'])
def financing_delete():
    if request.method == 'GET':
        return "GET is invalid in financing delete"
     
    if request.method == 'POST':
        id = request.form['id']
        cur = connection.cursor()
        cur.execute(''' DELETE FROM financing WHERE (project_id = %s)''',(id,))
        cur.execute(''' COMMIT''')
        cur.close()
        #return f"Done!!"
        return render_template('delete_complete.html')

@app.route('/organisation_phone_delete', methods = ['POST', 'GET'])
def organisation_phone_delete():
    if request.method == 'GET':
        return "GET is invalid in organisation_phone delete"
     
    if request.method == 'POST':
        id = request.form['id']
        number = request.form['number']
        cur = connection.cursor()
        cur.execute(''' DELETE FROM organisation_phone WHERE (organisation_id = %s
        AND telephone_number = %s)''',(id, number))
        cur.execute(''' COMMIT''')
        cur.close()
        #return f"Done!!"
        return render_template('delete_complete.html')

@app.route('/grading_delete', methods = ['POST', 'GET'])
def grading_delete():
    if request.method == 'GET':
        return "GET is invalid in grading delete"
     
    if request.method == 'POST':
        id = request.form['id']
        cur = connection.cursor()
        cur.execute(''' DELETE FROM grading WHERE (project_id = %s)''',(id,))
        cur.execute(''' COMMIT''')
        cur.close()
        #return f"Done!!"
        return render_template('delete_complete.html')

@app.route('/project_field_delete', methods = ['POST', 'GET'])
def project_field_delete():
    if request.method == 'GET':
        return "GET is invalid in project_field delete"
     
    if request.method == 'POST':
        id = request.form['id']
        name = request.form['name']
        cur = connection.cursor()
        cur.execute(''' DELETE FROM project_field WHERE (project_id = %s
        AND field_name = %s)''',(id, name))
        cur.execute(''' COMMIT''')
        cur.close()
        #return f"Done!!"
        return render_template('delete_complete.html')

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## UPDATE FORM FOR ALL TABLES
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

@app.route('/researcher_update_form')
def researcher_update_form():
    cur = connection.cursor()
    cur.execute(''' SELECT * FROM researcher''')
    researcher_list = cur.fetchall()
    cur.close()
    return render_template('researcher_update_form.html',researcher_list=researcher_list)

@app.route('/organisation_update_form')
def organisation_update_form():
    cur = connection.cursor()
    cur.execute(''' SELECT * FROM organisation''')
    organisation_list = cur.fetchall()
    #print(organisation_list)
    cur.close()
    return render_template('organisation_update_form.html',organisation_list=organisation_list)
    
@app.route('/project_update_form')
def project_update_form():
    cur = connection.cursor()
    cur.execute(''' SELECT * FROM project''')
    project_list = cur.fetchall()
    #print(project_list)
    cur.close()
    return render_template('project_update_form.html',project_list=project_list)
    
@app.route('/program_update_form')
def program_update_form():
    cur = connection.cursor()
    cur.execute(''' SELECT * FROM program''')
    program_list = cur.fetchall()
    #print(program_list)
    cur.close()
    return render_template('program_update_form.html',program_list=program_list)
    
@app.route('/field_update_form')
def field_update_form():
    cur = connection.cursor()
    cur.execute(''' SELECT * FROM field''')
    field_list = cur.fetchall()
    #print(field_list)
    cur.close()
    return render_template('field_update_form.html',field_list=field_list)
    
@app.route('/executive_update_form')
def executive_update_form():
    cur = connection.cursor()
    cur.execute(''' SELECT * FROM executive''')
    executive_list = cur.fetchall()
    #print(executive_list)
    cur.close()
    return render_template('executive_update_form.html',executive_list=executive_list)

@app.route('/employee_update_form')
def employee_update_form():
    cur = connection.cursor()
    cur.execute(''' SELECT employee.researcher_id, researcher.name, researcher.surname,
    employee.organisation_id, organisation.name
    FROM employee INNER JOIN researcher INNER JOIN  organisation
    WHERE (employee.researcher_id = researcher.id AND
    employee.organisation_id = organisation.id)
    ORDER BY organisation_id''')
    employee_list = cur.fetchall()
    cur.close()
    return render_template('employee_update_form.html',employee_list=employee_list)

@app.route('/deliverable_update_form')
def deliverable_update_form():
    cur = connection.cursor()
    cur.execute(''' SELECT project.id, project.title, deliverable.name, deliverable.deadline
    FROM deliverable INNER JOIN project
    WHERE (deliverable.project_id = project.id)
    ORDER BY project.id''')
    deliverable_list = cur.fetchall()
    cur.close()
    return render_template('deliverable_update_form.html',deliverable_list=deliverable_list)

@app.route('/grading_update_form')
def grading_update_form():
    cur = connection.cursor()
    cur.execute(''' SELECT grading.project_id, project.title, grading.grade, grading.date,
    researcher.id, researcher.name, researcher.surname
    FROM grading INNER JOIN project INNER JOIN researcher
    WHERE (grading.researcher_id = researcher.id AND grading.project_id = project.id)''')
    grading_list = cur.fetchall()
    cur.close()
    return render_template('grading_update_form.html',grading_list=grading_list)

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## ACTUAL UPDATES
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

@app.route('/researcher_update', methods = ['POST', 'GET'])
def researcher_update():
    if request.method == 'GET':
        return "GET is invalid in researcher update"
     
    if request.method == 'POST':
        id = request.form['id']
        name = request.form['name']
        surname = request.form['surname']
        birthdate = request.form['birthdate']
        gender = request.form['gender']
        cur = connection.cursor()
        if name: cur.execute(''' UPDATE researcher SET name = %s WHERE id = %s''',(name,id))
        if surname: cur.execute(''' UPDATE researcher SET surname = %s WHERE id = %s''',(surname,id))
        if birthdate: cur.execute(''' UPDATE researcher SET birthdate = %s WHERE id = %s''',(birthdate,id))
        cur.execute(''' UPDATE researcher SET gender = %s WHERE id = %s''',(gender,id))
        cur.execute(''' COMMIT''')
        cur.close()
        # #return f"Done!!"
        return render_template('update_complete.html')

@app.route('/organisation_update', methods = ['POST', 'GET'])
def organisation_update():
    if request.method == 'GET':
        return "GET is invalid in organisation update"
     
    if request.method == 'POST':
        id = request.form['id']
        name = request.form['name']
        shortname = request.form['short_name']
        city = request.form['city']
        postal_code = request.form['postal_code']
        street = request.form['street']
        category = request.form['category']
        cur = connection.cursor()
        if name: cur.execute(''' UPDATE organisation SET name = %s WHERE id = %s''',(name,id))
        if shortname: cur.execute(''' UPDATE organisation SET short_name = %s WHERE id = %s''',(shortname,id))
        if city: cur.execute(''' UPDATE organisation SET city = %s WHERE id = %s''',(city,id))
        if postal_code: cur.execute(''' UPDATE organisation SET postal_code = %s WHERE id = %s''',(postal_code,id))
        if street: cur.execute(''' UPDATE organisation SET street = %s WHERE id = %s''',(street,id))
        cur.execute(''' UPDATE organisation SET category = %s WHERE id = %s''',(category,id))
        cur.execute(''' COMMIT''')
        cur.close()
        # #return f"Done!!"
        return render_template('update_complete.html')

@app.route('/project_update', methods = ['POST', 'GET'])
def project_update():
    if request.method == 'GET':
        return "GET is invalid in project update"
     
    if request.method == 'POST':
        id = request.form['id']
        title = request.form['title']
        information = request.form['information']
        start = request.form['start']
        end = request.form['end']
        budget = request.form['budget']
        cur = connection.cursor()
        if title: cur.execute(''' UPDATE project SET title = %s WHERE id = %s''',(title,id))
        if information: cur.execute(''' UPDATE project SET information = %s WHERE id = %s''',(information,id))
        if start: cur.execute(''' UPDATE project SET start = %s WHERE id = %s''',(start,id))
        if end: cur.execute(''' UPDATE project SET end = %s WHERE id = %s''',(end,id))
        if budget: cur.execute(''' UPDATE project SET budget = %s WHERE id = %s''',(budget,id))
        cur.execute(''' COMMIT''')
        cur.close()
        # #return f"Done!!"
        return render_template('update_complete.html')

@app.route('/program_update', methods = ['POST', 'GET'])
def program_update():
    if request.method == 'GET':
        return "GET is invalid in program update"
     
    if request.method == 'POST':
        id = request.form['id']
        name = request.form['name']
        address = request.form['address']
        cur = connection.cursor()
        if name: cur.execute(''' UPDATE program SET name = %s WHERE id = %s''',(name,id))
        if address: cur.execute(''' UPDATE program SET address = %s WHERE id = %s''',(address,id))
        cur.execute(''' COMMIT''')
        cur.close()
        # #return f"Done!!"
        return render_template('update_complete.html')

@app.route('/field_update', methods = ['POST', 'GET'])
def field_update():
    if request.method == 'GET':
        return "GET is invalid in field update"
     
    if request.method == 'POST':
        name = request.form['name']
        new_name = request.form['new_name']
        cur = connection.cursor()
        if new_name: cur.execute(''' UPDATE field SET name = %s WHERE name = %s''',(new_name,name))
        cur.execute(''' COMMIT''')
        cur.close()
        # #return f"Done!!"
        return render_template('update_complete.html')

@app.route('/executive_update', methods = ['POST', 'GET'])
def executive_update():
    if request.method == 'GET':
        return "GET is invalid in executive update"
     
    if request.method == 'POST':
        id = request.form['id']
        name = request.form['name']
        surname = request.form['surname']
        cur = connection.cursor()
        if name: cur.execute(''' UPDATE executive SET name = %s WHERE id = %s''',(name,id))
        if surname: cur.execute(''' UPDATE executive SET surname = %s WHERE id = %s''',(surname,id))
        cur.execute(''' COMMIT''')
        cur.close()
        # #return f"Done!!"
        return render_template('update_complete.html')

@app.route('/employee_update', methods = ['POST', 'GET'])
def employee_update():
    if request.method == 'GET':
        return "GET is invalid in employee update"
     
    if request.method == 'POST':
        id = request.form['id']
        date = request.form['date']
        cur = connection.cursor()
        #print(date)
        if date: cur.execute(''' UPDATE employee SET date = %s WHERE researcher_id = %s''',(date,id))
        cur.execute(''' COMMIT''')
        cur.close()
        # #return f"Done!!"
        return render_template('update_complete.html')

@app.route('/deliverable_update', methods = ['POST', 'GET'])
def deliverable_update():
    if request.method == 'GET':
        return "GET is invalid in deliverable update"
     
    if request.method == 'POST':
        name = request.form['name']
        id = request.form['id']
        new_name = request.form['new_name']
        deadline = request.form['deadline']
        cur = connection.cursor()
        if new_name: cur.execute(''' UPDATE deliverable SET name = %s WHERE project_id = %s AND name = %s''',(new_name,id,name))
        if deadline: cur.execute(''' UPDATE deliverable SET deadline = %s WHERE id = %s AND name = %s''',(deadline,id,name))
        cur.execute(''' COMMIT''')
        cur.close()
        # #return f"Done!!"
        return render_template('update_complete.html')

@app.route('/grading_update', methods = ['POST', 'GET'])
def grading_update():
    if request.method == 'GET':
        return "GET is invalid in grading update"
     
    if request.method == 'POST':
        id = request.form['id']
        grade = request.form['grade']
        date = request.form['date']
        cur = connection.cursor()
        if grade: cur.execute(''' UPDATE grading SET grade = %s WHERE project_id = %s''',(grade,id))
        if date: cur.execute(''' UPDATE grading SET date = %s WHERE project_id = %s''',(date,id))
        cur.execute(''' COMMIT''')
        cur.close()
        # #return f"Done!!"
        return render_template('update_complete.html')

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## ADVANCED QUERY 1
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

@app.route('/advanced1_form')
def advanced1_form():
    cur = connection.cursor()
    cur.execute(''' SELECT * FROM executive''')
    executive_list = cur.fetchall()
    cur.close()
    return render_template('advanced1_form.html',executive_list=executive_list)

@app.route('/advanced1', methods = ['POST', 'GET'])
def advanced1():
    if request.method == 'GET':
        return "GET is invalid in advanced1"
     
    if request.method == 'POST':
        #Get all variables...
        min_start = request.form['min_start']
        max_start = request.form['max_start']
        min_end = request.form['min_end']
        max_end = request.form['max_end']
        min_duration = request.form['min_duration']
        max_duration = request.form['max_duration']
        exec_id = request.form['exec_id']
        test_exec = request.form['test_exec']
        #...and give values to the empty
        if not min_start: min_start = '1900-01-01'
        if not max_start: max_start = '2300-01-01'
        if not min_end: min_end = '1900-01-01'
        if not max_end: max_end = '2300-01-01'
        if not min_duration: min_duration = 1
        if not max_duration: max_duration = 99999
        if test_exec == '1':
            cur = connection.cursor()
            cur.execute(''' SELECT p.id, p.title, p.start, p.end, p.budget,
            e.id, e.name, e.surname 
            FROM (project AS p) INNER JOIN (executive AS e)
            INNER JOIN (admin_by_exec AS a)
            WHERE (p.start > %s AND p.start < %s
            AND p.end > %s AND p.end < %s
            AND ABS(DATEDIFF(p.start,p.end)) > %s
            AND ABS(DATEDIFF(p.start,p.end)) < %s
            AND p.id = a.project_id AND
            a.exec_id = e.id AND
            e.id = %s)''',(min_start,max_start,min_end,max_end,min_duration,max_duration,exec_id))
            proj_list = cur.fetchall()
            cur.close()
        else:
            cur = connection.cursor()
            cur.execute(''' SELECT * FROM project''')
            proj_list = cur.fetchall()
            cur.close()
        #return f"Done!!"
        return render_template('advanced1_form2.html', proj_list = proj_list)

@app.route('/advanced2', methods = ['POST', 'GET'])
def advanced2(): #Well, advanced2 is probably confusing name
    if request.method == 'GET':
        return "GET is invalid in advanced2"
     
    if request.method == 'POST':
        id = request.form['id']
        cur = connection.cursor()
        cur.execute(''' SELECT r.id, r.name, r.surname
        FROM (works_on_proj AS w)
        INNER JOIN (researcher AS r)
        WHERE (w.project_id = %s
        AND w.researcher_id = r.id)''',(id,))
        result = cur.fetchall()
        cur.close()
        contents = []
        contents1 = '<!DOCTYPE html><html><head><style>table, th, td {border: 1px solid black;border-collapse: collapse;}</style><meta charset="UTF-8"><title>Show works_on_projs</title></head><body>'
        tbl = "<table><tr><td>ID</td><td>Name</td><td>Surname</td></tr>"
        contents.append(contents1)
        contents.append(tbl)
        for row in result:
            a = "<tr><td>%s</td>"%row[0]
            contents.append(a)
            b = "<td>%s</td>"%row[1]
            contents.append(b)
            c = "<td>%s</td>"%row[2]
            contents.append(c)
        contents2 = "</table><button><a href='landing'>Back to landing</a></button></body></html>"
        contents.append(contents2)
        s = '\n'.join(contents)
        f = open("./templates/advanced1_show.html", "w", encoding = "UTF-8")
        f.write(s)
        f.close()
        return send_from_directory('./templates','advanced1_show.html')

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## ADVANCED QUERY 2
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

@app.route('/advanced2_view1')
def advanced2_view1():
    cur = connection.cursor()
    cur.execute(''' SELECT * FROM view1''')
    result = cur.fetchall()
    cur.close()
    contents = []
    contents1 = '<!DOCTYPE html><html><head><style>table, th, td {border: 1px solid black;border-collapse: collapse;}</style><meta charset="UTF-8"><title>Show employees</title></head><body>'
    tbl = "<table><tr><td>Name</td><td>Surname</td><td>Title</td></tr>"
    contents.append(contents1)
    contents.append(tbl)
    for row in result:
        a = "<tr><td>%s</td>"%row[0]
        contents.append(a)
        b = "<td>%s</td>"%row[1]
        contents.append(b)
        c = "<td>%s</td>"%row[2]
        contents.append(c)
    contents2 = "</table><button><a href='landing'>Back to landing</a></button>"
    contents.append(contents2)
    contents3 = '''<p>This view shows the names of researchers that work on a project
    or supervise it, and the title of the ascosciated project</p></body></html>'''
    contents.append(contents3)
    s = '\n'.join(contents)
    f = open("./templates/advanced2_view1_show.html", "w", encoding = "UTF-8")
    f.write(s)
    f.close()
    #return render_template('employee_show.html')
    return send_from_directory('./templates','advanced2_view1_show.html')

@app.route('/advanced2_view2')
def advanced2_view2():
    cur = connection.cursor()
    cur.execute(''' SELECT * FROM view2 ORDER BY surname''')
    result = cur.fetchall()
    cur.close()
    contents = []
    contents1 = '<!DOCTYPE html><html><head><style>table, th, td {border: 1px solid black;border-collapse: collapse;}</style><meta charset="UTF-8"><title>Show employees</title></head><body>'
    tbl = "<table><tr><td>Exec surname</td><td>Program</td></tr>"
    contents.append(contents1)
    contents.append(tbl)
    for row in result:
        a = "<tr><td>%s</td>"%row[0]
        contents.append(a)
        b = "<td>%s</td>"%row[1]
        contents.append(b)
    contents2 = "</table><button><a href='landing'>Back to landing</a></button>"
    contents.append(contents2)
    contents3 = '''<p>This view shows the surnames of executives and the
    names of the programs that are ascosciated by the same project</p></body></html>'''
    contents.append(contents3)
    s = '\n'.join(contents)
    f = open("./templates/advanced2_view2_show.html", "w", encoding = "UTF-8")
    f.write(s)
    f.close()
    return send_from_directory('./templates','advanced2_view2_show.html')

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## ADVANCED QUERY 3
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

@app.route('/advanced3_form')
def advanced3_form():
    cur = connection.cursor()
    cur.execute(''' SELECT * FROM field''')
    field_list = cur.fetchall()
    cur.close()
    return render_template('advanced3_form.html',field_list=field_list)

@app.route('/advanced3', methods = ['POST', 'GET'])
def advanced3():
    if request.method == 'GET':
        return "GET is invalid in advanced3"
     
    if request.method == 'POST':
        name = request.form['name']
        cur = connection.cursor()
        #I need one table for researchers, and another for projects
        #Researchers
        #-- The DATEDIFF() lines assure that the researcher
        #-- has worked on the project during the last year,
        #-- or that the project is currently running,
        #-- as required.
        cur.execute(''' SELECT DISTINCT r.id, r.name, r.surname
        FROM (works_on_proj AS w)
        INNER JOIN (researcher AS r)
        INNER JOIN (supervision AS s)
        INNER JOIN (project_field AS p)
        INNER JOIN (field AS f)
        INNER JOIN (project AS pro)
        WHERE ((r.id = w.researcher_id AND
        pro.id = w.project_id AND
        w.project_id = p.project_id AND
        p.field_name = %s AND
        ((DATEDIFF(NOW(),pro.start) < 365) OR
        (DATEDIFF(pro.end,NOW()) < 365) OR
        (pro.start < NOW() AND pro.end > NOW())))
        OR (r.id = s.researcher_id AND
        pro.id = s.project_id AND
        s.project_id = p.project_id AND
        p.field_name = %s AND
        ((DATEDIFF(NOW(),pro.start) < 365) OR
        (DATEDIFF(pro.end,NOW()) < 365) OR
        (pro.start < NOW() AND pro.end > NOW()))))''',(name,name))
        result = cur.fetchall()
        contents = []
        contents1 = '<!DOCTYPE html><html><head><style>table, th, td {border: 1px solid black;border-collapse: collapse;}</style><meta charset="UTF-8"><title>Show works_on_projs</title></head><body>'
        tbl = "<h4>Researchers:</h4><table><tr><td>ID</td><td>Name</td><td>Surname</td></tr>"
        contents.append(contents1)
        contents.append(tbl)
        for row in result:
            a = "<tr><td>%s</td>"%row[0]
            contents.append(a)
            b = "<td>%s</td>"%row[1]
            contents.append(b)
            c = "<td>%s</td>"%row[2]
            contents.append(c)
        contents2 = "</table><h4>Projects:</h4><table><tr><td>ID</td><td>Title</td></tr>"
        contents.append(contents2)
        #Projects. Only active, as requested
        cur.execute('''SELECT DISTINCT pro.id, pro.title
        FROM (project_field AS p)
        INNER JOIN (field AS f)
        INNER JOIN (project AS pro)
        WHERE (p.field_name = %s AND
        p.project_id = pro.id AND
        (pro.start < NOW() AND pro.end > NOW()))''',(name,))
        result = cur.fetchall()
        for row in result:
            a = "<tr><td>%s</td>"%row[0]
            contents.append(a)
            b = "<td>%s</td>"%row[1]
            contents.append(b)
        cur.close()
        contents2 = "</table><button><a href='landing'>Back to landing</a></button>"
        contents.append(contents2)
        s = '\n'.join(contents)
        f = open("./templates/advanced3_show.html", "w", encoding = "UTF-8")
        f.write(s)
        f.close()
        return send_from_directory('./templates','advanced3_show.html')

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## ADVANCED QUERY 4
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

@app.route('/advanced4')
def advanced4():
    cur = connection.cursor()
    cur.execute(''' CREATE TEMPORARY TABLE IF NOT EXISTS `my_base`.`org` (
    `id` INT NOT NULL,
    PRIMARY KEY (`id`))
    ENGINE = InnoDB''')
    cur.execute(''' CALL query3_4()''')
    cur.execute(''' SELECT organisation.id, organisation.name FROM
    org INNER JOIN organisation WHERE (org.id = organisation.id)''')
    result = cur.fetchall()
    cur.execute(''' DROP TEMPORARY TABLE org''')
    cur.close()
    contents = []
    contents1 = '''<!DOCTYPE html><html><head><style>
    table, th, td {border: 1px solid black;border-collapse: collapse;}</style>
    <meta charset="UTF-8"><meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <title>Query 3.4</title></head><body>'''
    tbl = "<table><tr><td>Org ID</td><td>Org Name</td></tr>"
    contents.append(contents1)
    contents.append(tbl)
    for row in result:
        a = "<tr><td>%s</td>"%row[0]
        contents.append(a)
        b = "<td>%s</td>"%row[1]
        contents.append(b)
    contents2 = "</table><button><a href='landing'>Back to landing</a></button></body></html>"
    contents.append(contents2)
    s = '\n'.join(contents)
    f = open("./templates/advanced4.html", "w", encoding = "UTF-8")
    f.write(s)
    f.close()
    return send_from_directory('./templates','advanced4.html')

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## ADVANCED QUERY 6
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

@app.route('/advanced6')
def advanced6():
    cur = connection.cursor()
    cur.execute(''' CREATE TEMPORARY TABLE IF NOT EXISTS `my_base`.`temp` (
    `id` INT NOT NULL,
    `counter` INT,
    PRIMARY KEY (`id`))
    ENGINE = InnoDB''')
    cur.execute(''' CALL query3_6()''')
    cur.execute(''' SELECT researcher.id, researcher.name,
    researcher.surname, CEIL(DATEDIFF(NOW(),researcher.birthdate)/365),
    temp.counter FROM temp INNER JOIN researcher WHERE 
    (temp.id = researcher.id) ORDER BY counter DESC''')
    result = cur.fetchall()
    cur.execute(''' DROP TEMPORARY TABLE temp''')
    cur.close()
    contents = []
    contents1 = '''<!DOCTYPE html><html><head><style>
    table, th, td {border: 1px solid black;border-collapse: collapse;}</style>
    <meta charset="UTF-8"><meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <title>Query 3.6</title></head><body>'''
    tbl = "<table><tr><td>Res ID</td><td>Res Name</td><td>Res Surname</td><td>Age</td><td>Count</td></tr>"
    contents.append(contents1)
    contents.append(tbl)
    for row in result:
        a = "<tr><td>%s</td>"%row[0]
        contents.append(a)
        b = "<td>%s</td>"%row[1]
        contents.append(b)
        c = "<td>%s</td>"%row[2]
        contents.append(c)
        d = "<td>%s</td>"%row[3]
        contents.append(d)
        e = "<td>%s</td>"%row[4]
        contents.append(e)
    contents2 = "</table><button><a href='landing'>Back to landing</a></button></body></html>"
    contents.append(contents2)
    s = '\n'.join(contents)
    f = open("./templates/advanced6.html", "w", encoding = "UTF-8")
    f.write(s)
    f.close()
    return send_from_directory('./templates','advanced6.html')

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## ADVANCED QUERY 7
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

@app.route('/advanced7')
def advanced7():
    cur = connection.cursor()
    cur.execute(''' CREATE TEMPORARY TABLE IF NOT EXISTS `my_base`.`temp7` (
    `id` INT NOT NULL,
    `company_id` INT,
    `money` INT,
    PRIMARY KEY (`id`,`company_id`))
    ENGINE = InnoDB''')
    cur.execute(''' CALL query3_7()''')
    cur.execute(''' SELECT executive.id, executive.name,
    executive.surname, organisation.id, organisation.name,
    temp7.money FROM temp7 INNER JOIN organisation INNER JOIN
    executive WHERE (temp7.id = executive.id) AND
    temp7.company_id = organisation.id ORDER BY money DESC''')
    result = cur.fetchall()
    cur.execute(''' DROP TEMPORARY TABLE temp7''')
    cur.close()
    contents = []
    contents1 = '''<!DOCTYPE html><html><head><style>
    table, th, td {border: 1px solid black;border-collapse: collapse;}</style>
    <meta charset="UTF-8"><meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <title>Query 3.7</title></head><body>'''
    tbl = "<table><tr><td>Ex ID</td><td>Ex Name</td><td>Ex Surname</td><td>Org ID</td><td>Org Name</td><td>Money</td></tr>"
    contents.append(contents1)
    contents.append(tbl)
    for row in result:
        a = "<tr><td>%s</td>"%row[0]
        contents.append(a)
        b = "<td>%s</td>"%row[1]
        contents.append(b)
        c = "<td>%s</td>"%row[2]
        contents.append(c)
        d = "<td>%s</td>"%row[3]
        contents.append(d)
        e = "<td>%s</td>"%row[4]
        contents.append(e)
        e1 = "<td>%s</td>"%row[5]
        contents.append(e1)
    contents2 = "</table><button><a href='landing'>Back to landing</a></button></body></html>"
    contents.append(contents2)
    s = '\n'.join(contents)
    f = open("./templates/advanced7.html", "w", encoding = "UTF-8")
    f.write(s)
    f.close()
    return send_from_directory('./templates','advanced7.html')

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## ADVANCED QUERY 8
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

@app.route('/advanced8')
def advanced8():
    cur = connection.cursor()
    cur.execute(''' CREATE TEMPORARY TABLE IF NOT EXISTS `my_base`.`temp8` (
    `id` INT NOT NULL,
    `counter` INT,
    PRIMARY KEY (`id`))
    ENGINE = InnoDB''')
    cur.execute(''' CALL query3_8()''')
    cur.execute(''' SELECT researcher.id, researcher.name,
    researcher.surname, temp8.counter FROM temp8 INNER JOIN
    researcher WHERE (temp8.id = researcher.id)
    ORDER BY counter DESC''')
    result = cur.fetchall()
    cur.execute(''' DROP TEMPORARY TABLE temp8''')
    cur.close()
    contents = []
    contents1 = '''<!DOCTYPE html><html><head><style>
    table, th, td {border: 1px solid black;border-collapse: collapse;}</style>
    <meta charset="UTF-8"><meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <title>Query 3.8</title></head><body>'''
    tbl = "<table><tr><td>Res ID</td><td>Res Name</td><td>Res Surname</td><td>Counter</td></tr>"
    contents.append(contents1)
    contents.append(tbl)
    for row in result:
        a = "<tr><td>%s</td>"%row[0]
        contents.append(a)
        b = "<td>%s</td>"%row[1]
        contents.append(b)
        c = "<td>%s</td>"%row[2]
        contents.append(c)
        d = "<td>%s</td>"%row[3]
        contents.append(d)
    contents2 = "</table><button><a href='landing'>Back to landing</a></button></body></html>"
    contents.append(contents2)
    s = '\n'.join(contents)
    f = open("./templates/advanced8.html", "w", encoding = "UTF-8")
    f.write(s)
    f.close()
    return send_from_directory('./templates','advanced8.html')

if(__name__ == "__main__"):
  app.run(host='localhost', port=5000)