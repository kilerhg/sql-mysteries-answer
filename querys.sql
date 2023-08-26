SELECT date(SUBSTRING(date,1,4) || '-' || SUBSTRING(date,5,2) || '-' || SUBSTRING(date,7,2)) as date, "type", description, city
FROM crime_scene_report
;

SELECT id, age, height, eye_color, hair_color, gender, plate_number, car_make, car_model
FROM drivers_license;

SELECT person_id, event_id, event_name, date(SUBSTRING(date,1,4) || '-' || SUBSTRING(date,5,2) || '-' || SUBSTRING(date,7,2)) as date
FROM facebook_event_checkin;

SELECT membership_id, 
		date(SUBSTRING(check_in_date,1,4) || '-' || SUBSTRING(check_in_date,5,2) || '-' || SUBSTRING(check_in_date,7,2)) as check_in_date, 
		check_in_time as check_in_time_minutes, 
		check_out_time  as check_in_time_minutes,
		(check_out_time - check_in_time)/60  as total_hours_spend,
		check_out_time - check_in_time  as total_minutes_spend
FROM get_fit_now_check_in
order by total_hours_spend asc;

SELECT id, person_id, name, 
	date(SUBSTRING(membership_start_date,1,4) || '-' || SUBSTRING(membership_start_date,5,2) || '-' || SUBSTRING(membership_start_date,7,2)) as membership_start_date, membership_status
FROM get_fit_now_member;

SELECT ssn, annual_income
FROM income;

SELECT person_id, transcript
FROM interview;

SELECT id, name, license_id, address_number, address_street_name, ssn
FROM person;
