-- Create Database

CREATE TABLE salesperson(
	salesperson_id SERIAL PRIMARY KEY,
	first_name VARCHAR(100),
	last_name VARCHAR(100)
);

CREATE TABLE mechanic(
	mechanic_id SERIAL PRIMARY KEY,
	first_name VARCHAR(100),
	last_name VARCHAR(100)
);

CREATE TABLE customer(
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	address VARCHAR(150),
	email VARCHAR(150),
	billing_info VARCHAR(30)
);

CREATE TABLE vehicle(
	vin VARCHAR(100) PRIMARY KEY,
	make VARCHAR(100),
	model VARCHAR(100),
	year_ NUMERIC(4),
	color VARCHAR(50),
	new_or_used VARCHAR(5)
);

CREATE TABLE service_invoice(
	service_id SERIAL PRIMARY KEY,
	customer_id INTEGER,
	vin VARCHAR(100),
	service_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP(0),
	service_type VARCHAR(150),
	price NUMERIC(8,2),
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
	FOREIGN KEY(vin) REFERENCES vehicle(vin)
);

CREATE TABLE service_ticket(
	ticket_id SERIAL PRIMARY KEY,
	mechanic_id INTEGER,
	service_id INTEGER,
	FOREIGN KEY(mechanic_id) REFERENCES mechanic(mechanic_id),
	FOREIGN KEY(service_id) REFERENCES service_invoice(service_id)
);

CREATE TABLE sales_invoice(
	sales_id SERIAL PRIMARY KEY,
	customer_id INTEGER,
	salesperson_id INTEGER,
	vin VARCHAR(100),
	sales_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP(0),
	price NUMERIC(8,2),
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
	FOREIGN KEY(salesperson_id) REFERENCES salesperson(salesperson_id),
	FOREIGN KEY(vin) REFERENCES vehicle(vin)
);



--------------- Populate Tables -----------------

CREATE OR REPLACE FUNCTION add_customer(
	_first_name VARCHAR,
	_last_name VARCHAR,
	_address VARCHAR,
	_email VARCHAR,
	_billing_info VARCHAR
)
RETURNS void
AS $$
BEGIN
	INSERT INTO customer(first_name, last_name, address, email, billing_info)
	VALUES(_first_name, _last_name, _address, _email, _billing_info);
END;
$$
LANGUAGE plpgsql;

SELECT add_customer('Bo', 'Burnham', '1000 Main St, Los Angeles, CA 90035', 'bburnham@gmail.com', '4444 4444 4444 4444 321 08/23');
SELECT add_customer('Ryan', 'Reynolds', '200 North St, Los Angeles, CA 90035', 'ryan_reynolds@gmail.com', '4444 5555 4444 5555 678 09/23');



CREATE OR REPLACE FUNCTION add_salesperson(
	_first_name VARCHAR,
	_last_name VARCHAR
)
RETURNS void
AS $$
BEGIN
	INSERT INTO salesperson(first_name, last_name)
	VALUES(_first_name, _last_name);
END;
$$
LANGUAGE plpgsql;

SELECT add_salesperson('Ricky', 'Bobby');
SELECT add_salesperson('Kenny', 'Powers');




INSERT INTO vehicle(
	vin,
	make,
	model,
	year_,
	color,
	new_or_used
)VALUES(
	'1HGBH41JXMN109186',
	'ford',
	'escape',
	2013,
	'black',
	'used'
);


INSERT INTO vehicle(
	vin,
	make,
	model,
	year_,
	color,
	new_or_used
)VALUES(
	'5UXXW3C53J0T80683',
	'jeep',
	'cherokee',
	2020,
	'black',
	'new'
);


INSERT INTO mechanic(
	mechanic_id,
	first_name,
	last_name
)VALUES(
	1,
	'Larry',
	'David'
);

INSERT INTO mechanic(
	mechanic_id,
	first_name,
	last_name
)VALUES(
	2,
	'Jason',
	'Bateman'
);


INSERT INTO service_invoice(
	customer_id,
	vin,
	service_type,
	price
)VALUES(
	1,
	'1HGBH41JXMN109186',
	'oil change',
	50.00
);

INSERT INTO service_invoice(
	customer_id,
	vin,
	service_type,
	price
)VALUES(
	2,
	'5UXXW3C53J0T80683',
	'tire replacement x 4',
	1000.00
);


INSERT INTO service_ticket(
	ticket_id,
	mechanic_id,
	service_id
)VALUES(
	1,
	1,
	1
);

INSERT INTO service_ticket(
	ticket_id,
	mechanic_id,
	service_id
)VALUES(
	2,
	1,
	2
);


INSERT INTO sales_invoice(
	customer_id,
	salesperson_id,
	vin,
	price
)VALUES(
	2,
	2,
	'5UXXW3C53J0T80683',
	39999.99
);

INSERT INTO sales_invoice(
	customer_id,
	salesperson_id,
	vin,
	price
)VALUES(
	1,
	2,
	'1HGBH41JXMN109186',
	15999.99
);