/*
-- colums removed due to only 50% or less are populated (from pandas)
'notes',
 'thumbnail_url',
 'medium_url',
 'xl_picture_url',
 'square_feet',
 'weekly_price',
 'monthly_price',
 'license',
 'jurisdiction_names'
 */


SELECT 
	   id = cast(id as int)
--      ,listing_url -- url constant + id
      ,scrape_id = cast(scrape_id as bigint) -- id
--      ,last_scraped -- date, looks similar to scrape_id
      ,name =  cast([name] as varchar(200)) -- id
--     ,summary -- text
--     ,space -- text
--     ,description -- text
--     ,experiences_offered -- all same value (none)
--     ,neighborhood_overview -- text
--      ,notes -- less than 50%
--      ,transit -- text
--      ,access -- text
--      ,interaction -- text
--     ,house_rules -- text
--      ,thumbnail_url -- removed <50%
 --     ,medium_url-- removed <50%
      ,picture_url = cast(picture_url as varchar(200))
--      ,xl_picture_url -- removed <50%
      ,host_id = cast(host_id as int) -- id
--      ,host_url --- constant url + host id
--      ,host_name
      ,host_since = cast(host_since as date)
--      ,host_location -- text
--      ,host_about -- text
      ,host_response_time = cast(host_response_time as varchar(50)) -- 'several blank records, can be combined with N/A -- values: within an hour, N/A, within a few hours, within a day, a few days or more'
      ,host_response_rate = cast(host_response_rate as varchar(50)) --N/A	19001
      ,host_acceptance_rate = cast(host_acceptance_rate as varchar(50))--N/A	14010, several blank
      ,host_is_superhost = cast(host_is_superhost as char(1)) -- several blank, abt 40k false, abt 10k true - sampling consideration?
--      ,host_thumbnail_url -- same as host pict, but smaller
--      ,host_picture_url -- host_has_profile_pic is better column to use
      ,host_neighbourhood = cast(host_neighbourhood as varchar(50))
      ,host_listings_count = cast(host_listings_count as int)
 --     ,host_total_listings_count -- same as host listing count
      ,host_verifications = cast(host_verifications as varchar(200)) -- mulitple values, create new column to count how many verification/host -- sample: 'email', 'phone', 'reviews', 'kba'
      ,host_has_profile_pic = cast(host_has_profile_pic as char(1))  -- t/f -- several blank
      ,host_identity_verified  = cast(host_identity_verified as char(1)) -- t/f-- several blank
      ,street = cast(street as varchar(100))
      ,neighbourhood = cast(neighbourhood as varchar(100))
      ,neighbourhood_cleansed = cast(neighbourhood_cleansed as varchar(100))
	  ,calc_neighbourhod_listing_is_wrong = cast(case when neighbourhood = '' then ''
												when neighbourhood <> neighbourhood_cleansed then 't' 
												else 'f' end as char(1))
      ,neighbourhood_group_cleansed = cast(neighbourhood_group_cleansed as varchar(20)) --- maybe better to start with, only 5 groups
      ,city = cast(city as varchar(50))-- some blanks and bad city names
      ,state = cast(state as varchar(10))-- mostly NY, but some states are wrong: CA, NJ, etc
      ,zipcode = cast(zipcode as varchar(20)) -- clean up needed if we are going to use it (check for string mix)
--      ,market -- dont' seem usefull, mostly New York
--      ,smart_location -- use neighbourhood_group_cleansed instead
--      ,country_code -- all US
--      ,country -- all US
      ,latitude = cast(latitude as varchar(20))-- id
      ,longitude = cast(longitude as varchar(20)) -- id
      ,is_location_exact = cast(is_location_exact as char(1)) -- t = 41983, f = 8813 
      ,property_type = cast(is_location_exact as varchar(50)) -- category
      ,room_type = cast(room_type as varchar(20))  -- category: Entire home/apt, Private room, Shared room, Hotel room
      ,accommodates = cast(accommodates as int) -- number of people can stay from 2 to 22
      ,bathrooms = cast(case when bathrooms = '' then '99' else bathrooms end as numeric(3,1)) -- number of bathroom from blank to 15.5, change blank to 99
      ,bedrooms  = cast(case when bedrooms = '' then '99' else bedrooms end as int)  -- number bedrooms from blank to 21, change blank to 99
      ,beds  = cast(case when beds = '' then '99' else beds end as int) -- number of beds from blank to 40, change blank to 99
      ,bed_type  = cast(bed_type as varchar(20))-- category: Real Bed, Futon, Pull-out Sofa, Airbed, Couch
      ,amenities = cast(amenities as varchar(2000)) -- list of amenities, needs to parse this to yes no -- {TV,"Cable TV",Wifi,"Air conditioning",Gym,Elevator,Heating,"Smoke detector","First aid kit","Fire extinguisher",Essentials,Shampoo,"Lock on bedroom door",Hangers,"Hair dryer",Iron,"Laptop friendly workspace","Self check-in","Building staff",Bathtub,"Hot water","Bed linens","Extra pillows and blankets","Luggage dropoff allowed","Wide hallways","No stairs or steps to enter","Wide entrance for guests","Flat path to guest entrance","Well-lit path to entrance","No stairs or steps to enter"}
--      ,square_feet-- removed <50%
      ,price = cast(replace(replace(price,'$',''), ',','') as numeric(8,2))-- string (has dollar sign and comma) needs to convert to integer, as target -- from 0 to 10000, remove 0 dollar
--      ,weekly_price-- removed <50%
--      ,monthly_price-- removed <50%
      ,security_deposit = case when security_deposit = '' then cast(0 as numeric(8,2)) else cast(replace(replace(security_deposit,'$',''), ',','') as numeric(8,2)) end  -- 	17325 is blank - fill in with 0
      ,cleaning_fee = case when cleaning_fee = '' then cast(0 as numeric(8,2)) else cast(replace(replace(cleaning_fee,'$',''), ',','') as numeric(8,2)) end  -- 	10528 is blank - fill in with 0
      ,guests_included = cast(guests_included as smallint) -- number of guests, more than half is 1, 1 to 16
      ,extra_people = case when extra_people = '' then cast(0 as numeric(5,2)) else cast(replace(replace(extra_people,'$',''), ',','') as numeric(5,2)) end -- cost for extra people, string ($sign and comma) 0-300
      ,minimum_nights = cast(minimum_nights as int) -- some crazy number needs to be removed maybe more than 30 days?
      ,maximum_nights = cast(maximum_nights as int)  -- some crazy number needs to be removed maybe more than 30 days?
--      ,minimum_minimum_nights -- seems useless, remove for now
--      ,maximum_minimum_nights -- seems useless, remove for now
--      ,minimum_maximum_nights -- seems useless, remove for now
--      ,maximum_maximum_nights -- seems useless, remove for now
--      ,minimum_nights_avg_ntm -- seems useless, remove for now
--      ,maximum_nights_avg_ntm -- seems useless, remove for now
      ,calendar_updated = cast(maximum_nights as varchar(20)) --- category, all over the place from today to never
--      ,has_availability -- all true -- useless
--      ,availability_30 -- remove for now
--      ,availability_60 -- remove for now
--      ,availability_90 -- remove for now
--      ,availability_365 -- remove for now
--      ,calendar_last_scraped -- remove for now
      ,number_of_reviews = cast(number_of_reviews as int) -- category: 0 to 408, needs grouping
      ,number_of_reviews_ltm = cast(number_of_reviews_ltm as int) -- category: 0 to 351, not sure how is it difference from number_of_reviews
      ,first_review = cast(first_review as date) -- dates - maybe convert to category
      ,last_review = cast(last_review as date)  -- dates - maybe convert to category
      ,review_scores_rating = cast(case when review_scores_rating = '' then 101 else review_scores_rating end as int)--- blank to 100 (total of all), convert blank to 101 for tracibility
      ,review_scores_accuracy = cast(case when review_scores_accuracy = '' then 11 else review_scores_accuracy end as int)--- blank to 10, convert blank to 11 for tracibility
      ,review_scores_cleanliness = cast(case when review_scores_cleanliness = '' then 11 else review_scores_cleanliness end as int)--- blank to 10, convert blank to 11 for tracibility
      ,review_scores_checkin = cast(case when review_scores_checkin = '' then 11 else review_scores_checkin end as int)--- blank to 10, convert blank to 11 for tracibility
      ,review_scores_communication = cast(case when review_scores_communication = '' then 11 else review_scores_communication end as int)--- blank to 10, convert blank to 11 for tracibility
      ,review_scores_location = cast(case when review_scores_location = '' then 11 else review_scores_location end as int)--- blank to 10, convert blank to 11 for tracibility
      ,review_scores_value = cast(case when review_scores_value = '' then 11 else review_scores_value end as int)--- blank to 10, convert blank to 11 for tracibility
--      ,requires_license -- all false, useless
--      ,license -- removed <50%
--      ,jurisdiction_names-- removed <50%
      ,instant_bookable = cast(instant_bookable as char(1))-- true false
--      ,is_business_travel_ready -- all false, useless
      ,cancellation_policy = cast(cancellation_policy as varchar(50)) -- category: super_strict_60,super_strict_30,strict_14_with_grace_period,strict,moderate,flexible
--      ,require_guest_profile_picture -- mostly false, only 1000 true, remove for now
--      ,require_guest_phone_verification-- mostly false, only 1000 true, remove for now
      --,calculated_host_listings_count -- remove for now
      --,calculated_host_listings_count_entire_homes-- remove for now
      --,calculated_host_listings_count_private_rooms-- remove for now
      --,calculated_host_listings_count_shared_rooms-- remove for now
      ,reviews_per_month = cast(case when reviews_per_month = '' then cast('99' as numeric(4,2)) else reviews_per_month end as numeric(4,2)) -- convert blank to 99 for tracability

--	into Sandbox.dbo.ABB_Listing_Selected

  FROM Sandbox.dbo.ABB_Listing

/*
----- summary with dollar sign
--select  cast(replace(substring(price, 2,10), ',', '') as numeric(10,2)), count(*) from ABB_Listing
--group by cast(replace(substring(price, 2,10), ',', '') as numeric(10,2))
--order by 1 desc
---- other summary
select  extra_people, count(*) from ABB_Listing
group by extra_people
order by 1 desc


--select listing_id, count(distinct price) from ABB_Calendar
--group by listing_id
--order by 2 desc

select listing_id, 
		min(cast(replace(replace(price,'$', ''), ',', '') as numeric(6,2))), 
		max(cast(replace(replace(price,'$', ''), ',', '') as numeric(6,2))), 
		count(distinct price) 
from ABB_Calendar
where listing_id = 37926696
group by listing_id
order by 1 desc

*/