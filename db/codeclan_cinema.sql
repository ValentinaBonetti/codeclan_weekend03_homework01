DROP TABLE tickets;
DROP TABLE screenings;
DROP TABLE customers;
DROP TABLE films;
DROP TABLE theatres;
DROP TABLE cinemas;

CREATE TABLE cinemas(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  theatres_list VARCHAR(255) ARRAY,
  till INT8
);

CREATE TABLE theatres(
  id SERIAL4 PRIMARY KEY,
  theatre_number VARCHAR(255),
  available_seats INT4
);

CREATE TABLE films(
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(255),
  price INT4
);

CREATE TABLE customers(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  wallet INT4
);

CREATE TABLE screenings(
  id SERIAL4 PRIMARY KEY,
  start_time VARCHAR(255),
  empty_seats INT2,
  film_id INT4 REFERENCES films(id) ON DELETE CASCADE
);

CREATE TABLE tickets(
  id SERIAL4 PRIMARY KEY,
  customer_id INT4 REFERENCES customers(id) ON DELETE CASCADE,
  screening_id INT4 REFERENCES screenings(id) ON DELETE CASCADE
);
