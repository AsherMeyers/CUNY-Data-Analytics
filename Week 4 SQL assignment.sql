DROP TABLE IF EXISTS org_chart;

CREATE TABLE org_chart (
	staff_id int PRIMARY KEY,
    staff_name varchar(30),
    title varchar(30),
    supervisor varchar(30)    

);

INSERT INTO org_chart (staff_id, staff_name, title, supervisor) 
	VALUES (1, "Steve Jobs", "CEO", "God");
INSERT INTO org_chart (staff_id, staff_name, title, supervisor) 
	VALUES (2, "Peter Oppenheimer", "SVP, Chief Financial Officer", "Steve Jobs");
INSERT INTO org_chart (staff_id, staff_name, title, supervisor) 
	VALUES (3, "Philip Schiller", "SVP, Marketing", "Steve Jobs");
INSERT INTO org_chart (staff_id, staff_name, title, supervisor) 
	VALUES (4, "Scott Forstall", "SVP, iOS Software", "Steve Jobs");
INSERT INTO org_chart (staff_id, staff_name, title, supervisor) 
	VALUES (5, "Betsy Rafael", "SVP, iOS Software", "Peter Oppenheimer");
INSERT INTO org_chart (staff_id, staff_name, title, supervisor) 
	VALUES (6, "Greg Joswiak", "VP iPhone Marketing", "Philip Schiller");
INSERT INTO org_chart (staff_id, staff_name, title, supervisor) 
	VALUES (7, "Kim Vorrath", "VP Program Management", "Scott Forstall");

    
SELECT * FROM org_chart;
    
