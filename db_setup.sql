CREATE DATABASE flights;


\connect flights;


CREATE TABLE weather (
     ID varchar(10) NOT NULL,
     type text NOT NULL,
     severity text,
     starttimeUTC timestamp,
     endtimeUTC timestamp,
     timezone text,
     airport varchar(5),
     latitude numeric,
     longitude numeric,
     city text,
     county text,
     state varchar(2),
     zip numeric(5),
     PRIMARY KEY (ID)
);



CREATE TABLE flight_details (
     day_of_week integer,
     flight_date date NOT NULL,
     reporting_airline varchar(2),
     RA_DOT numeric(5),
     RA_IATA varchar(2),
     tail_number varchar(6),
     origin_ID numeric(5),
     origin_seqID numeric(7),
     origin_citymarket numeric(5),
     origin varchar(3),
     origin_city text,
     origin_statecode varchar(2),
     origin_state text,
     origin_worldareacode integer,
     dest_ID numeric(5),
     dest_seqID numeric(7),
     dest_citymarket numeric(5),
     dest varchar(3),
     dest_city text,
     dest_statecode varchar(2),
     dest_state text,
     dest_worldareacode integer,
     set_dep_time integer,
     actual_dep_time varchar(4),
     dep_delay numeric,
     taxi_out numeric,
     wheels_off varchar(10),
     wheels_on varchar(10),
     taxi_in numeric,
     set_arr_time varchar(4) NOT NULL,
     actual_arr_time varchar(4) NOT NULL,
     arr_delay varchar(10),
     canceled numeric,
     diverted numeric,
     set_elapsed_time varchar(10),
     actual_elapsed_time varchar(10),
     air_time numeric,
     num_of_flights numeric,
     miles numeric,
     diverted_landings integer,
     diverted_to_dest_elapsed_time numeric,
     diverted_to_dest_arr_delay numeric,
     placeholder varchar(1) --csv file contains extra blank column
);


\copy weather FROM 'WeatherEvents_2016-2019.csv' CSV HEADER;
\copy flight_details FROM PROGRAM 'awk FNR-1 2019-flights/* | cat' CSV HEADER;



/*Add column for more commonly used airport code*/

ALTER TABLE weather
ADD airport_clean varchar(4);

UPDATE weather SET airport_clean = RIGHT(airport, LENGTH(airport) - 1);
