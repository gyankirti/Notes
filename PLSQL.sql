PL/SQL 	
Procedural Language / Standard Query Language
Extensively used to code server side programming


Blocks -

Anonymous Block			Named Block

Declaration
Execution - Only mandatory section in PLSQL block
Exception Handling


Example 1 : 

SET SERVER OUTPUT ON; - special command which allows the display of the ouput on you output device
DECLARE
	v_test VARCHAR2(15) := 'GYAN';
	
or

SET SERVER OUTPUT ON; - special command which allows the display of the ouput on you output device
DECLARE
	v_test VARCHAR2(15);
BEGIN
	v_test := 'MyName';
	DBMS_OUTPUT.PUT_LINE(v_test);
END;

Variable declaration can be done only on the Declare section of the PLSQL block
Variable initialisation can be done anywhere (i.e. either in the declaration section or in the execution section)

Example 2 - SELECT INTO STATEMENT

DECLARE
	v_salary number(8);
BEGIN
	SELECT salary INTO v_salary FROM employees
	WHERE employee_id = 100;
	DBMS_OUTPUT.PUT_LINE(v_salary);
END;
/

OR

DECLARE
	v_salary number(8);
	v_fname VARCHAR2(20);
BEGIN
	SELECT salary,first_name INTO v_salary.v_fname FROM employees
	WHERE employee_id = 100;
	DBMS_OUTPUT.PUT_LINE(v_fname || ' Has salary '||v_salary);
END;
/



-- Anchored Datatype in PL/SQL (%TYPE)

Variable_name Typed_Attr %TYPE

SET SERVEROUTPUT ON;

DECLARE
	v_fname students.first_name%TYPE;
BEGIN
	select first_name into v_fname FROM students where 
	stu_id = 1;
	DBMS_OUTPUT.PUTLINE(v_fname);
END;
/


--- CONSTANT - should be initialised at its declaration
SET SERVEROUTPUT ON;

DECLARE
	v_pi CONSTANT NUMBER(7,6) := 3.141592; -- DEFAULT keyword can be used in place of assignment operator'
										   -- v_pi CONSTANT NUMBER(7,6) DEFAULT 3.141592;
BEGIN
	DBMS_OUTPUT.PUTLINE(v_pi);
END;
/

-- Different types of variables
-- User Vartiables and Bind Variables (Host Variable)


VARIABLE v_bindl VARCHAR2(10);

Initialising the bind variable 

1. Using Execute command -

EXEC :v_bindl := 'ExamplesString';

2. Using execution Block

BEGIN
	:v_bind1 := 'Manish Sharma'; -- You can reference a bind variable in PLSQL by using colon immediately followed by the bind operator name
END;
/

-- Displaying the output og a bind variable
1. DBMS_OUTPUT

2. PRINT command

PRINT :v_bind1

-- Doesn't need any PLSQL block for displaying the output
-- If no argument is given, it will print of all the bind variables with their names in the session

3. Setting the AUTOPRINT ON
SET AUTOPRINT ON;


Example 1

SET AUTOPRINT ON;
VARIABLE v_bond2 VARCHAR2(30);
EXEC :v_bind2 := 'Manish';



---Conditional Statements


1. if - then 
	
Example 1

2. if - then - else 

If then else  executes sequence of statements only when the condition is evaluated to be TRUE


if condition THEN
	statement 1;
else condition then 
	statement 2;
end if ;
	statement 3
	
Example 2

SET SERVEROUTPUT ON;
DECLARE
	v_num NUMBER := &enter_number; -- & Takes the input from the user
BEGIN
	IF MOD(v_num,2) = 0 THEN -- MOD divides the first parameter with the second parameter and matches the output
		DBMS_OUTPUT.PUT_LINE(v_num||'Is even');
	ELSE
		DBMS_OUTPUT.PUT_LINE(v_num||'is odd');
	END IF;
		DBMS_OUTPUT.PUT_LINE('if  then else complete');
END;

3. IF THEN ELSIF
	
	
	
-- ITERATIVE STATEMENTS - LOOPS

1. SIMPLE LOOP
2. WHILE LOOP
3. NUMERIC FOR LOOP
4. CURSOR FOR LOOP


Example 1:

SET SERVEROUTPUT ON;
DECLARE 
	v_counter NUMBER := 0;
	v_result NUMBER;
BEGIN
	LOOP
		v_counter := v_counter + 1;
		v_result := 19 * v_counter;
		DBMS_OUTPUT.PUT_LINE(v_result);
		IF v_counter >= 10 THEN --- in place of this block just WRITE
							    --- EXIT WHEN v_counter >= 10
			EXIT;
		END IF;
	END LOOP;
END;

Example 2: While Loop

SET SEVER OUTPUT ON;

DECLARE 
	v_cnt NUMBER := 1;
	v_res NUMBER;
BEGIN
	WHILE cnt <= 10 LOOP
		v_res := 19*v_cnt;
		DBMS_OUTPUT.PUT_LINE(v_res);
		v_cnt := v_cnt + 1;
	END LOOP;
END;

Example 3: Boolean Expression in a while loop


DECLARE 
	v_cnt NUMBER := 0;
	v_test BOOLEAN := TRUE;
BEGIN
	WHILE v_test LOOP
		v_cnt := v_cnt+1;
		DBMS_OUTPUT.PUT_LINE(v_cnt);
		-- Loop termination code
		IF v_cnt = 10 THEN v_test = FALSE;
		END IF;
	END LOOP;
END;
/

## NOTE: WHILE loops are used when the number of iterations are unknown
		 FOR loops are used when the number of iterations are known

Example 4: FOR LOOPS

SET SERVEROUTPUT ON;
BEGIN
	FOR v_cnt in [REVERSE] 1 .. 10 LOOP -- v_cnt is an implicit index integer variable
							  -- which gets defined with the definition of the for loop
		DBMS_OUTPUT.PUT_LINE(v_cnt);
	END LOOP;
END;



--- TRIGGERS in PLSQL
--- Specialized stored programs which execute implicitly when a triggering event occurs
-- Triggering event -- DML,DDL,System Event, User Event

Types Of TRIGGERS
->DDL
->DML
->System/DB 
->Instead-of
->Compound   


Example 1 - DML Trigger - INSERT TRIGGER

CREATE TABLE superheroes(
	sh_name VARCHAR2(20)
);

SET SERVEROUTPUT ON;
CREATE OR REPLACE TRIGGER bi_superheroes
BEFORE INSERT ON superheroes
FOR EACH ROW
ENABLE
DECLARE 
	v_user VARCHAR2(20);
BEGIN
	SELECT user INTO v_user FROM DUAL;
	DBMS_OUTPUT.PUT_LINE('You just inserted a line Mr. '|| v_user);
END;
/

Example 2 - Generic DML Trigger


SET SERVEROUTPUT ON;
CREATE OR REPLACE TRIGGER tr_superheroes
BEFORE INSERT OR DELETE OR UPDATE ON superheroes
FOR EACH ROW
ENABLE
DECLARE
	v_user VARCHAR2(20);
BEGIN
	SELECT user INTO v_user FROM DUAL;
	IF INSERTING THEN 
		DBMS_OUTPUT.PUT_LINE('You are inserting a row Mr. '|| v_user);
	ELSIF UPDATING THEN
		DBMS_OUTPUT.PUT_LINE('You are updating a row Mr. '|| v_user);
	ELSIF DELETING THEN
		DBMS_OUTPUT.PUT_LINE('You are deleting a row Mr. '|| v_user);
	END IF;
END;


-- Table Auditing using DML TRIGGERS

Table auditing means keeping a track of all the dml activities performed on a specific table of the database for example which user Inserted, updated or deleted a row from the table and when. 
It is like spying on the users who are messing your table’s data.
Pseudo Record         ‘: NEW’, allows you to access a row currently being processed. In other words, when a row is being inserted or updated into the superheroes table. 
Whereas Pseudo Record ‘: OLD’ allows you to access a row which is already being either Updated or Deleted from the superheroes table.


For an INSERT trigger, OLD contain no values, and NEW contain the new values.
For an UPDATE trigger, OLD contain the old values, and NEW contain the new values.
For a DELETE trigger, OLD contain the old values, and NEW contain no values.


Example 1:


-- sh_audit table should be created before the trigger creation

CREATE OR REPLACE trigger superheroes_audit
BEFORE INSERT OR DELETE OR UPDATE ON superheroes
FOR EACH ROW
ENABLE
DECLARE
  v_user varchar2 (30);
  v_date  varchar2(30);
BEGIN
  SELECT user, TO_CHAR(sysdate, 'DD/MON/YYYY HH24:MI:SS') INTO v_user, v_date  FROM dual;
  IF INSERTING THEN
    INSERT INTO sh_audit (new_name,old_name, user_name, entry_date, operation) 
    VALUES(:NEW.SH_NAME, Null , v_user, v_date, 'Insert');  
  ELSIF DELETING THEN
    INSERT INTO sh_audit (new_name,old_name, user_name, entry_date, operation)
    VALUES(NULL,:OLD.SH_NAME, v_user, v_date, 'Delete');
  ELSIF UPDATING THEN
    INSERT INTO sh_audit (new_name,old_name, user_name, entry_date, operation) 
    VALUES(:NEW.SH_NAME, :OLD.SH_NAME, v_user, v_date,'Update');
  END IF;
END;
/ 	



-- Making a Synchronized backup copy of a Table

Table1 - Main Table - Accepts data from the user 
Table2 - Backup table

--Example 1
--Main Table
CREATE TABLE superheroes(
	Sh_name VARCHAR2(30)
);

create table superhero_bkp as select * from superheroes;

CREATE OR REPLACE trigger superhero_bkp
BEFORE INSERT OR UPDATE OR DELETE ON superheroes
FOR EACH ROW
ENABLE
DECLARE 
BEGIN
	IF INSERTING THEN INSERT INTO SUPERHERO_BKP (sh_name) VALUES (:NEW.sh_name);
	ELSIF UPDATING THEN UPDATE SUPERHERO_BKP SET sh_name = :NEW.sh_name where sh_name = :OLD.sh_name;
	ELSIF DELETING THEN DELETE FROM SUPERHERO_BKPWHERE sh_name = :OLD.sh_name;
	END IF;
END;



-- These types of triggers dont work well with heavy data volumes.


--- DDL triggers
--Using DDL triggers we can track changes to the database
DDL triggers are the triggers which are created over DDL statements such as CREATE, DROP or ALTER. 
Using this type of trigger you can monitor the behavior and force rules on your DDL statements.
http://www.rebellionrider.com/schema-database-auditing-using-ddl-trigger-in-pl-sql/#.VmrFlvl97IU



--Table to store the ddl info

CREATE TABLE schema_audit
  (
    ddl_date       DATE,
    ddl_user       VARCHAR2(15),
    object_created VARCHAR2(15),
    object_name    VARCHAR2(15),
    ddl_operation  VARCHAR2(15)
  );
 

CREATE OR REPLACE TRIGGER hr_audit_tr 
AFTER DDL ON SCHEMA
BEGIN
    INSERT INTO schema_audit VALUES (
sysdate, 
sys_context('USERENV','CURRENT_USER'), 
ora_dict_obj_type, 
ora_dict_obj_name, 
ora_sysevent);
END;
/

--If you will notice carefully the second line of the code (“AFTER DDL ON SCHEMA”) indicates that this trigger will work on the schema in which it is created.






------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------





-- CURSORS
-- Cursor is a pointer to a memory area called context area

Context area is a memory region inside the PGA which helps the oracle server in processing an SQL 
statement by holding importnt info abput that statement

--> ROws returned by a Query
--> Number of rows processed by a Query
--> a pointer to the parsed query in the shared pool

-- Using the cursor you can control the context area as it is apointer to the same



Cursors - Explicit and implicit

-- Implicit Cursor - Created by oracle itself everytime a DML statement is executed. User can't control the behavior of such cursors
-- Oracle server creates an implicit cursor for any PLSQL Block which executes an SQL statement. as long as an explicit cursor doesn;t exist for that statement

-- Explicit Cursor - User defined cursors
-- User has to create explicit cursors for any sq2l statement which returns more than 1 row of data

DECLARE  -- CURSOR cursor_name IS select_statement;
-- initialising a cursor into memory, intialisation happens in the declaration section of the PLSQL Block
OPEN -- OPEN cursor_name
-- In order to put that cursor to use we have to open the cursor first
-- when you open a cursor, memory will be alloted to it
FETCH -- FETCH cursor_name INTO PLSQL_variable/PLSQL_record
-- process of retrieving the data from a cursor is called fetching
CLOSE -- CLOSE cursor_name
--FREES all the occupied resources

SET SERVER OUTPUT ON;
DECLARE 
	v_name VARCHAR2(30);
	CURSOR cur_test IS
	SELECT first_name FROM employees
	where employee_id < 105;
	
BEGIN
	OPEN cur_test
	LOOP
		FETCH cur_test INTO v_name;
		DBMS_OUTPUT.PUT_LINE(v_name);
		EXIT WHEN cur_test%NOTFOUND;
	END LOOP;
	CLOSE cur_test;
END;

-- Cursor attribute %NOTFOUND is a Booleanattribute which returns TRUE only when previous FETCH commamd
-- did not return a single row


---- PARAMETERIZED CURSOR


SET SERVER OUTPUT ON;

DECLARE 
	v_name VARCHAR2(30);
	CURSOR p_test(test_var VARCHAR2) IS 
	SELECT first_name FROM employees
	WHERE employee_id<test_var;
BEGIN
	OPEN test_var(105);
	LOOP;
		FETCH p_test INTO v_name;
		DBMS_OUTPUT.PUT_LINE(v_name);
		EXIT WHEN p_test%NOTFOUND;
	END LOOP;
	CLOSE p_test;
END;
/


--- PRAMETEIZED CURSOR with a default VALUE

--Setting a default value for the parameter means that if the user has not supplied any value for the parameter then the default value will be taken for the parameter

---- CURSOR FOR LOOP
-- Reduced the burden of opening closing and fetching the cursor

FOR loop_index IN curosr_name
	LOOP
		statements
	END LOOP;
	
--Example 1

SET SERVEROUTPUT ON;

DECLARE
	CURSOR CUR_TEST IS 
	SELECT first_name, last_name FROM employees
	WHERE employee_id >200;
BEGIN 
	FOR L_IDX IN cur_test
	LOOP
		DBMS_OUTPUT.PUT_LINE(L_IDX.FIRST_NAME||' '||L_IDX.SECOND_NAME);
	END LOOP;
END;
/




---- RECORDS 
-- records are composite data structure made up of different components called fielsds
-- these fields can have different data types
-- table based, cursor based , user defined


Syntax:

variable_name table_name%ROWTYPE;

variable_name cursor_name%ROWTYPE;


-- Table based records

-- Creating a table based record 
-- whenever you declare a record typre variable oracle declares a composite DS with fields
-- correspnding to the fields of the table mentioned

-- Exsmple 1 

SET SERVEROUTPUT ON
DECLARE 
	v_emp employees%ROWTYPE;
BEGIN
	SELECT  * INTO FROM employees
	where employee_id = 100;
	
	DBMS_OUTPUT.PUT_LINE(v_emp.first_name ||' '|| v_emp.last_name);
	
END;

-- Fetch data from the selected columns of a Table
-- name of the column should be specified from where we want to fetch the data 

SET SERVEROUTPUT ON;
DECLARE 
	v_emp employees%ROWTYPE;
BEGIN
	SELECT first_name, hire_date INTO v_emp.first_name, v_emp.hire_date FROM employees
	WHERE employee_id = 100;
	
	DBMS_OUTPUT.PUT_LINE(v_emp.first_name);
	
END;


--CURSOR based records
-- Those variables whose structure is derived from the select list of an already created cursor
-- the fields of the record are initialized by fetching the data from the select list of the cursor
-- which was used to create this VARIABLE

steps Involved 

-> Declaration of cursor based Record
-> initialization  of the cursor based Record
-> accessing the data stored into the cursor based record variable

SET SERVEROUTPUT ON;
DECLARE 
	CURSOR cur_test IS 
	SELECT first_name, salary FROM employees
	WHERE 	employee_id > 200;
	
	var_emp cur_test%ROWTYPE;
	
BEGIN
	OPEN cur_test;
	FETCH cur_test INTO var_emp;
	LOOP
	EXIT WHEN cur_test%NOTFOUND;
	DBMS_OUTPUT.PUT_LINE(var_emp.first_name||' '||var_emp.last_name);
	END LOOP;
	CLOSE cur_test;
	
END;



-- USER defined Records

-- User defined recordsa re the record variables whose structure is defined by the user

-- Syntax 

TYPE type_name IS RECORD(
	field_name1 datatype1;
	field_name2 datatype2;
	...
	field_nameN datatypeN;
);

record_name TYPE_NAME; -- Declare


SET SERVEROUTPUT ON;
DECLARE
	TYPE rv_dept IS RECORD(
		f_name VARCHAR 2(20);
		D_NAME DEPARTMENTS.department_no%TYPE
	);
	var1 rv_dept;
BEGIN
	SELECT first_name, department_name INTO var1.f_name,var1.D_NAME
	FROM employees join deoartments USING (department_id) WHERE employee_id = 100;
	DBMS_OUTPUT.PUT_LINE(var1.f_name||' '||var1.D_NAME);
END;
/







-- FUNCTIONS - a self conrtained program which used to do some specific well defined task

-- named PLSQL blocks whoch means they can be stored into the database object as a database object and can be reused

CREATE OR REPLACE FUNCTION circle_area(radius NUMBER)
RETURN NUMBER IS 

pi CONSTANT NUMBER (7,3) := 3.141;
area NUMBER(7,3);

BEGIN
	area := pi*(raidus*radius);
	return area;
END;
/


BEGIN
DBMS_OUTPUT.PUT_LINE(circle_area(25));
END
/


-- Stored Procedures

-- The only difference between a functiona and a stored procedure is that stored procedure doesn't return any value but function rreturns a value
-- i.e. value returned by  procedure cannot be assigned to a variable

-- Example

-- Write a stored procedure and try calling it using a named PLSQL block such as PLSQL Function or a trigger


-- Write a stored procedure to calculate the 3rd highest salary of an employees



select min(salary) from emplyees where salary in (select salary from employees order by salary desc where rownum<3);



----Calling notation for PLSQL subroutines




-- Packages
-- named plsql blocks mean they are stored  permanently in the db


CREATE OR REPLACE PACKAGE pkg_test IS 
	FUNCTION prnt_strg RETURN VARCHAR2;
	PROCEDURE proc_test (f_name varchar2, l_name varchar2);
END pkg_test;





---------------------------------------------------------------------------------------------------------------------------

-- Exception Handling

Any abnormal condition that interrupts the normal flow of your programs
instructions at runtime is Exception

i.e. Exception is a runtime error

-> system defined EXCEPTIONS
-> user - defined Exception


1. using variable of EXCEPTION type
2. Using PRAGMA_INIT type
3. using RAISE_APPLICATION_ERROR method

1. Using a variable of exception type


DECLARE
	var_dividend NUMBER:=24;
	var_divisor NUMBER :=0;
	var_result NUMBER;
	ex_DivZero EXCEPTION;
BEGIN
	IF var_divisor = 0 THEN
		RAISE ex_DivZero;
	END IF;
	var_result := var_dividend/var_divisor;
	DBMS_OUTPUT.PUT_LINE(var_result);
	EXCEPTION WHEN exDivZero THEN 
		DBMS_OUTPUT.PUT_LINE('ERROR');
END;
/
Raise statement changes the normal flow of execution of the code
As soon as the compiler comes across a raise condition it transfers the control over to the exception handler


-- USER DEFINED EXCEPTION USING RAISE APPLICATION ERROR

ACCEPT var_age NUMBER PROMT 'What is your AGE'; -- to give a prompt for taing ijnput from the User
DECLARE
	age NUMBER := &var_age;
BEGIN
	IF age < 18 THEN
		RAISE_APPLICATION_ERROR(-20008,'Age should be greater than 18');
	END IF;
	
	DBMS_OUTPUT.PUT_LINE('Sure, what would you like to have');
	
	EXCEPTION WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/


--PRAGMA EXCEPTION_INIT

using the PRAGMA EXCEPTION_INIT we can associate an
exception name with an oracle error number

-- PRAGMA EXCEPTION_INIT (exception_name, error_number);

DECLARE
	ex_age EXCEPTION;
	age NUMBER := 17;
	PRAGMA EXCEPTION_INIT(ex_age,-20008);
BEGIN
	IF age<18 THEN
		RAISE_APPLICATION_ERROR(-20008,'You should be 18 or above for drinke')
	END IF;
	
	DBMS_OUTPUT.PUT_LINE('Sure, what do you want');
	
	EXCEPTION WHEN ex_age THEN
		DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



COLLECTIONS


-- a homogeneous single dimension DS which is made of elements of same datatype is called collection in oracle
-- unlike array plsql collections are 1D

-- Collections can be be created inside the PLSQL block or as db objects
-- if created inside a PLSQL block, the scope is limited to the Block
-- when created as a db object, can be reused again and again


2 types of collectios

--> Persistent collection,those collections which store the collection structure with data physically into the db and 
-- can be accessed again if NEEDED

--> Nested TABLES
--> VARRAYS

--> Non Persistent collections

--> Associative arrays -- cannot be reused and available in the plsql block for the session


--NESTED TABLE
##NOTE## 
index values start with 1, not 0

SET SERVEROUTPUT ON;
DECLARE 
	TYPE my_nested_table IS TABLE OF number;
	var_nt my_nested_table := my_nested_table(8,3,4,5,6,718,5,3,3,3,3);
BEGIN
	DBMS_OUTPUT.PUT_LINE(var_nt(1));
END;
/

OR

BEGIN
	FOR idx in 1..var_nt.COUNT
	LOOP
		DBMS_OUTPUT.PUT_LINE(var_nt(idx));
	END LOOP;
END;
/


-- CREATING NESTED TABLE AS DB COLLECTION OBJECT USING PRIMITIVE DATATYPE

CREATE OR REPLACE TYPE my_nested_table IS TABLE OF VARCHAR2 (10);
/

-- The collection type which we created above can be used to specify the type of a column of a table.
-- Using clause NESTED TABLE we specify the name of the column and using STORE AS clause we specify the storage table for the nested table.

CREATE TABLE my_subject(
	  sub_id    	NUMBER,
	  sub_name  	VARCHAR2 (20),
	  sub_schedule_day    my_nested_table
) NESTED TABLE sub_schedule_day STORE AS nested_tab_space;
/

--insert rows into the table 

INSERT INTO my_subject (sub_id, sub_name, sub_schedule_day)
VALUES (101, 'Maths', my_nested_table('mon', 'Fri'));

-- Update all the values of the nested table type column.
UPDATE my_subject SET sub_schedule_day = my_nested_table('Tue', 'Sat') 
WHERE sub_id = 101;
/


Update single instance of nested table
In order to update a single instance of nested table type column you can once again take the help of TABLE expression.

UPDATE TABLE
  (SELECT sub_schedule_day FROM my_subject 
  WHERE sub_id = 101) A
SET A.COLUMN_VALUE   = 'Thur' 
WHERE A.COLUMN_VALUE = 'Sat';
/



-- In Oracle, like other programming languages, object type is a kind of a datatype which works in the same way as other datatypes 
-- such as Char, Varchar2, Number etc. but with more flexibility.

CREATE OR REPLACE TYPE object_type AS OBJECT (
  obj_id  NUMBER,
  obj_name  VARCHAR2(10)
);
/


--- Creating a user defined datatype

CREATE OR REPLACE TYPE My_NT IS TABLE OF object_type;
/

http://www.rebellionrider.com/how-to-create-nested-table-using-user-define-datatype-in-oracle-database/#.WOZEI9J97RY



---------------VARRAYS-----------------------

variable sized arrays - persistent objects - but bounded  collections unlike nested TABLES
-- Bounded means you have to specify the number of elements you want in the collection while declaring it

-- size of the varray can be altered after declaration


SET SERVEROUTPUT ON;
CREATE OR REPLACE TYPE dobj_vry IS VARAAY (5) OF NUMBER;

CREATE TABLE calender (
	day_name VARCHAR2(25);
	day_date dobj_vry; -- can hold upto 5 values
);
-- No store as clause used as in nested table to specify the external storage table
-- As varrays don't require any external table for its storage
-- They are stored inline as row values in their parent TABLE

INSERT INTO calender (day_name,day_date)
VALUES ('Sunday', dobj_vry(7,14,21,28));

select 
	tab1.day_name,
	vry.column_value
from calender tab1, TABLE (tab1.day_date) vry;




----- Associative array -----

-- Holds elements of same data type in key value pairs
-- Non persistent
-- Unbounded collection like nested table
-- can only be created inside the declaration section of a PLSQL Block
