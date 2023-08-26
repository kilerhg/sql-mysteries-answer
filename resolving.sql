SELECT date(SUBSTRING(date,1,4) || '-' || SUBSTRING(date,5,2) || '-' || SUBSTRING(date,7,2)) as date, "type", description, city
FROM crime_scene_report
where type = 'murder'
and
date = '20180115'
;

'
Security footage shows that there were 2 witnesses. The first witness lives at the last house on "Northwestern Dr". The second witness, named Annabel, lives somewhere on "Franklin Ave".
'


--- find witness

SELECT id, name, license_id, address_number, address_street_name, ssn
FROM person
where address_street_name = 'Northwestern Dr'
order by address_number desc
;


SELECT id, name, license_id, address_number, address_street_name, ssn
FROM person
where name like 'Annabel%'
and
address_street_name = 'Franklin Ave'
;

'
1 witness - Annabel Miller - 14887

I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". Only gold members have those bags. The man got into a car with a plate that included "H42W".

2 witness - Morty Schapiro - 16371

I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.
'


SELECT person_id, transcript
FROM interview
where person_id = '67318';

--- Find suspects

"
Suspect 1* - 67318 - Jeremy Bowers - Owner of the car that left the place

I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017.

"

SELECT membership_id, 
		date(SUBSTRING(check_in_date,1,4) || '-' || SUBSTRING(check_in_date,5,2) || '-' || SUBSTRING(check_in_date,7,2)) as check_in_date, 
		check_in_time as check_in_time_minutes, 
		check_out_time  as check_in_time_minutes,
		(check_out_time - check_in_time)/60  as total_hours_spend,
		check_out_time - check_in_time  as total_minutes_spend
FROM get_fit_now_check_in
where check_in_date = '20180109'
and membership_id like '48Z%'
order by total_hours_spend asc;

SELECT id, person_id, name, 
	date(SUBSTRING(membership_start_date,1,4) || '-' || SUBSTRING(membership_start_date,5,2) || '-' || SUBSTRING(membership_start_date,7,2)) as membership_start_date, membership_status
FROM get_fit_now_member
where id = '48Z55';

48Z7A
48Z55

SELECT *
FROM person
join get_fit_now_member gfnm on gfnm.person_id = person.id
join drivers_license dl on dl.id = person.license_id
where gfnm.id = '48Z55'
;



SELECT id, age, height, eye_color, hair_color, gender, plate_number, car_make, car_model
FROM drivers_license;

--- Find the murderer

SELECT date(SUBSTRING(date,1,4) || '-' || SUBSTRING(date,5,2) || '-' || SUBSTRING(date,7,2)) as date, "type", description, city
FROM crime_scene_report
where
date <= '20180115'
and
description like '%LS%'
;

SELECT date(SUBSTRING(date,1,4) || '-' || SUBSTRING(date,5,2) || '-' || SUBSTRING(date,7,2)) as date, "type", description, city
FROM crime_scene_report
;

SELECT DISTINCT city
FROM crime_scene_report
;

SELECT DISTINCT type
FROM crime_scene_report
;

INSERT INTO solution VALUES (1, "Jeremy Bowers");

SELECT value FROM solution;

'
Congrats, you found the murderer! But wait, there's more... If you think you're up for a challenge, try querying the interview transcript of the murderer to find the real villain behind this crime.
 If you feel especially confident in your SQL skills, try to complete this final step with no more than 2 queries. Use this same INSERT statement with your new suspect to check your answer.
'

----- the real villain

'''
I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017.
'''

select DISTINCT car_make, car_model from drivers_license dl
where car_make = 'Tesla'
order by car_model desc
;

select DISTINCT car_model from drivers_license dl
order by car_model desc
;

SELECT *
FROM person
join drivers_license dl on dl.id = person.license_id
join income i on i.ssn = person.ssn 
join facebook_event_checkin fec on fec.person_id = person.id
where hair_color = 'red'
and gender = 'female'
and height >= 65
and height <= 67
and dl.car_make = 'Tesla'
and dl.car_model = 'Model S'
and fec.event_id = '1143'
;

SELECT person_id, event_id, event_name, date(SUBSTRING(date,1,4) || '-' || SUBSTRING(date,5,2) || '-' || SUBSTRING(date,7,2)) as date
FROM facebook_event_checkin
where event_name = 'SQL Symphony Concert';


INSERT INTO solution VALUES (1, "Miranda Priestly");

SELECT value FROM solution;










