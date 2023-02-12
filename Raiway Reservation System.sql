create database railway;
use railway;
create table employee
(
 	Employee_Id int primary key,
 	Employee_name varchar(50),
 	Address varchar(255),
 	Gender enum ('M','F'),
 	Phone_no int,
 	Date_of_birth date,
 	Salary int
);


insert into employee
values
(100,'Sahir','Employee Address 1','M','999540423','1977-12-01',50000),
(101,'Jishnu','Employee Address 2','M','989512487','1978-08-05',30000),
(103,'Drishya','Employee Address 3','F','705642487','1978-08-05',25000);

insert into employee
values
(104,'Gayathri','Employee Address 4','F','678064247','1987-08-05',100000);

insert into employee
values
(105,'Devi','Employee Address 5','F','997152450','1985-01-01',100);

select * from employee;

create table passenger
(
Pasenger_id int primary key,
Passenger_name varchar(50),
Seat_number int,
Gender enum('M', 'F'),
Phone_number varchar(50),
Employee_id int,
foreign key (Employee_Id) references employee (Employee_Id),
Reservation_status varchar(50)
);

select * from passenger;
insert into passenger
values
(1,'Jagan',12,'M','999545641',100,'confirmed'),
(2,'Bobby',59,'M','808945641',101,'waiting'),
(3,'Midhun',60,'M','708944541',103,'confirmed');

create table station
(
Station_Id varchar(255) primary key,
Station_name varchar(255),
Number_of_lines int,
Number_of_platforms int
);

insert into station
values
('station 1','Trivandrum',4,6),
('station 2','Varkala',4,5),
('station 3','Kollam',4,4),
('station 5','Alapuzha',3,6),
('station 6','Ernakulam',5,5);

insert into station
values 
('station 7','Kozhikode',5,5),
('station 8','Kannur',5,6),
('station 9','Chennai',5,10),
('station 10','Delhi',5,9);


create table train
(
Train_id varchar(255) primary key,
Station_Id varchar(255),
foreign key (Station_Id) references station(Station_Id),
Train_name varchar(255)
);

insert into train
values
('12076','station 1','Jan Shadabti'),
('66089','station 2','Chennai Express'),
('12075','station 3','Raptisagar Express');


create table ticket
(
Ticket_number int primary key,
Source varchar(255),
Destination varchar(255),
Class_id varchar(255),
Fare int,
Train_id varchar(255),
foreign key (Train_id) references train (Train_id)
);

insert into ticket
values
(901,'Trivandrum','Chennai','1A',1500, 12076),
(902,'Trivandrum','Chennai','1A',2500, 66089),
(903,'Trivandrum','Chennai','1A',1800, 12075);

select * from ticket;

update ticket
set destination='Kozhikode' where train_id=12076;

update ticket
set destination='Kannur' where train_id=66089;

create table fare
(
Receipt_number int,
Train_id varchar(255) primary key,
Source varchar(255),
Destination varchar(255),
Class varchar(255),
Fare int,
Ticket_number int,
foreign key (Ticket_number) references ticket (Ticket_number)
);

insert into fare
values
(1,12076,'Trivandrum','Kozhikode','1A',1500,901),
(2,12075,'Trivandrum','Chennai','1A',1800,903),
(3,66089,'Trivandrum','Kannur','1A',2500,902);

create table class
(
Class varchar(255),
Journey_date date,
Number_of_seats int,
Train_id varchar(255),
foreign key (Train_id) references fare (Train_id)
);

insert into class
values
('1A','2022-11-16',1,'12076'),
('1A','2022-10-06',1,'12075'),
('1A','2022-08-22',1,'66089');

create table time
(
Reference_number varchar(255),
Department_time TIME, -- this is now departing_time
Arrival_time time primary key,
Train_id varchar(255),
Station_id varchar(255)
);

alter table time
rename column Department_time to Departing_Time;

insert into time
values
(1000,'05:55:00','09:30:00','12076','station 6'),
(1001,'09:15:00','14:00:00','66089','station 8'),
(1002,'02:15:00','18:00:00','12075','station 10');

select * from time;

create table route
(
Arrival_time time,
foreign key (Arrival_time) references time(Arrival_time),
Department_time time, -- this is now departing_time
Stop_number int
);

insert into route
values
('09:30:00','05:55:00',6),
('14:00:00','09:15:00',8),
('18:00:00','02:15:00',10);

alter table route
rename column Department_time to Departing_Time;


-- question #1
-- 1.	Select employee name, gender as male employees, salary from employee where
-- gender=’M’ and salary < (select min(salary) from employee where gender=’F’)

select employee_name,gender as male_employees,salary from employee
where gender='M' and salary <(select min(salary) from employee where gender='F');

-- question #2
-- Select passenger name as passenger name , gender, reservation status, employee id from passenger where employee id=100;

Select passenger_name, gender, reservation_status, employee_id from passenger where employee_id=100;

-- question #3
-- Select train id, source, destination, class, fare from fare where source=’Trivandrum’ and fare>10;

Select train_id, source, destination, class, fare from fare where source='Trivandrum' and fare>10;

-- question #4
-- Select train id, source, destination, class, fare from fare where source='Trivandrum' and fare=(select max(fare)
-- from fare where source='Trivandrum');

Select train_id, source, destination, class, fare from fare where source='Trivandrum'
and fare=(select max(fare) from fare where source='Trivandrum');

-- question #5
-- Select station name, number of lines, number of platforms from station
-- where number of lines >=1 and number of platforms>=10;

use railway;
Select station_name, number_of_lines, number_of_platforms from station
where number_of_lines >=1 and number_of_platforms>=10;

-- question #6
-- Select train id, train name, station id from train where not station_id ='ARZ';

Select train_id, train_name, station_id from train where not station_id ='ARZ';

-- question #7
 -- Select class. Train id, train name, class from class inner join train on class. Train id= train. train id;

SELECT 
    cl.class, cl.Train_id, t.train_name
FROM
    class cl
        INNER JOIN
    train t ON cl.Train_id = t.train_id;
    
    -- question #8
    -- Select employee. E name, employee. Phone number, employee. Gender, p name, res status from employee
    -- join passenger on employee. E id=passenger. e_id;
    
    Select e.employee_name, e.Phone_no, e.Gender, p.passenger_name, p.reservation_status from employee e
    join passenger p on e.employee_id=p.employee_id;
    
    
    -- question #9
    -- Select employee. E_name, employee. Phone number, employee. Gender, p_name, res status from employee
    -- join passenger on employee. Id =passenger. E id and employee. phone number like ‘4%1’;
    
   SELECT 
    e.Employee_name,
    e.Phone_no,
    e.Gender,
    p.passenger_name,
    p.reservation_status
FROM
    employee e
        JOIN
    passenger p ON e.employee_id = p.employee_id
        AND p.passenger_name LIKE 'B%';
    
    Select Employee_name from employee;
    
    -- question #10
    -- Select station id, train name, class.class, class.no of seats, journey date from train
    -- join class on train. Train id=Class. Train id and journey date like ‘01%2019’;
    
    Select st.station_id, tr.train_name, cl.class, cl.number_of_seats, cl.journey_date from train tr
    join class cl on tr.Train_id=cl.Train_id
    join station st on st.station_id=tr.station_id and cl.journey_date like '2%16';
    
    -- question #11
    -- 11.	Select fare. receipt_no, fare.train id, train.train_name, fare.source, fare.destination, fare.class,
    -- fare.fare, fare.ticket_not, time.dep_time, time.arr_time from fare join ticket
    -- on fare.ticket_no = ticket.ticket_no  join time on time.train_id = ticket.train_id
    -- join train on ticket.train_id  = train.train_id;
    
Select fare.receipt_number, fare.train_id, train.train_name, fare.Source, fare.destination, fare.class, fare.fare,
fare.ticket_number, time.departing_time, time.arrival_time from fare fare
join ticket ticket on fare.train_id=ticket.train_id
join time time on time.train_id= ticket.train_id
join train train on ticket.train_id=train.train_id;