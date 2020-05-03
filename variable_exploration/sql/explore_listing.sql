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


SELECT TOP (1000) 
	   [id]
--      ,[listing_url] -- url constant + id
      ,[scrape_id] -- id
      ,[last_scraped] --id
      ,[name] -- id
--     ,[summary] -- text
--     ,[space] -- text
--     ,[description] -- text
--     ,[experiences_offered] -- all same value (none)
--     ,[neighborhood_overview] -- text
--      ,[notes] -- text
--      ,[transit] -- text
--      ,[access] -- text
--      ,[interaction] -- text
--     ,[house_rules] -- text
--      ,[thumbnail_url] -- removed <50%
 --     ,[medium_url]-- removed <50%
      ,[picture_url]
--      ,[xl_picture_url] -- removed <50%
      ,[host_id] -- id
--      ,[host_url] --- constant url + host id
--      ,[host_name]
      ,[host_since]
      ,[host_location]
--      ,[host_about] -- text
      ,[host_response_time] -- 'several blank records, can be combined with N/A -- values: within an hour, N/A, within a few hours, within a day, a few days or more'
      ,[host_response_rate] --N/A	19001
      ,[host_acceptance_rate] --N/A	14010, several blank
      ,[host_is_superhost] -- several blank, abt 40k false, abt 10k true - sampling consideration?
--      ,[host_thumbnail_url] -- same as host pict, but smaller
--      ,[host_picture_url] -- [host_has_profile_pic] is better column to use
      ,[host_neighbourhood]
      ,[host_listings_count]
 --     ,[host_total_listings_count] -- same as host listing count
      ,[host_verifications] -- mulitple values, create new column to count how many verification/host -- sample: ['email', 'phone', 'reviews', 'kba']
      ,[host_has_profile_pic] -- t/f -- several blank
      ,[host_identity_verified] -- t/f-- several blank
      ,[street]
      ,[neighbourhood]
      ,[neighbourhood_cleansed]
      ,[neighbourhood_group_cleansed] --- maybe better to start with, only 5 groups
      ,[city] -- some blanks and bad city names
      ,[state] -- mostly NY, but some states are wrong: CA, NJ, etc
      ,[zipcode] -- clean up needed if we are going to use it (check for string mix)
--      ,[market] -- dont' seem usefull, mostly New York
--      ,[smart_location] -- use [neighbourhood_group_cleansed] instead
--      ,[country_code] -- all US
--      ,[country] -- all US
      ,[latitude] -- id
      ,[longitude] -- id
      ,[is_location_exact] -- t = 41983, f = 8813 
      ,[property_type] -- category
      ,[room_type]  -- category: Entire home/apt, Private room, Shared room, Hotel room
      ,[accommodates] -- number of people can stay from 2 to 22
      ,[bathrooms] -- number of bathroom from blank to 15.5
      ,[bedrooms] -- number bedrooms from blank to 21
      ,[beds] -- number of beds from blank to 40
      ,[bed_type] -- category: Real Bed, Futon, Pull-out Sofa, Airbed, Couch
      ,[amenities] -- list of amenities, needs to parse this to yes no -- {TV,"Cable TV",Wifi,"Air conditioning",Gym,Elevator,Heating,"Smoke detector","First aid kit","Fire extinguisher",Essentials,Shampoo,"Lock on bedroom door",Hangers,"Hair dryer",Iron,"Laptop friendly workspace","Self check-in","Building staff",Bathtub,"Hot water","Bed linens","Extra pillows and blankets","Luggage dropoff allowed","Wide hallways","No stairs or steps to enter","Wide entrance for guests","Flat path to guest entrance","Well-lit path to entrance","No stairs or steps to enter"}
      ,[square_feet]-- removed <50%
      ,[price] -- string (has dollar sign and comma) needs to convert to integer, as target -- from 0 to 10000, remove 0 dollar
--      ,[weekly_price]-- removed <50%
--      ,[monthly_price]-- removed <50%
      ,[security_deposit] -- 	17325 is blank - fill in with 0
      ,[cleaning_fee] -- 	10528 is blank - fill in with 0
      ,[guests_included] -- number of guests, more than half is 1, 1 to 16
      ,[extra_people] -- cost for extra people, string ($sign and comma) 0-300
      ,[minimum_nights] -- some crazy number needs to be removed maybe more than 30 days?
      ,[maximum_nights] -- some crazy number needs to be removed maybe more than 30 days?
--      ,[minimum_minimum_nights] -- seems useless, remove for now
--      ,[maximum_minimum_nights] -- seems useless, remove for now
--      ,[minimum_maximum_nights] -- seems useless, remove for now
--      ,[maximum_maximum_nights] -- seems useless, remove for now
      ,[minimum_nights_avg_ntm]
      ,[maximum_nights_avg_ntm]
      ,[calendar_updated] --- category, all over the place from today to never
--      ,[has_availability] -- all true -- useless
--      ,[availability_30] -- remove for now
--      ,[availability_60] -- remove for now
--      ,[availability_90] -- remove for now
--      ,[availability_365] -- remove for now
--      ,[calendar_last_scraped] -- remove for now
      ,[number_of_reviews]
      ,[number_of_reviews_ltm]
      ,[first_review]
      ,[last_review]
      ,[review_scores_rating]
      ,[review_scores_accuracy]
      ,[review_scores_cleanliness]
      ,[review_scores_checkin]
      ,[review_scores_communication]
      ,[review_scores_location]
      ,[review_scores_value]
      ,[requires_license]
      ,[license]
      ,[jurisdiction_names]
      ,[instant_bookable]
      ,[is_business_travel_ready]
      ,[cancellation_policy]
      ,[require_guest_profile_picture]
      ,[require_guest_phone_verification]
      ,[calculated_host_listings_count]
      ,[calculated_host_listings_count_entire_homes]
      ,[calculated_host_listings_count_private_rooms]
      ,[calculated_host_listings_count_shared_rooms]
      ,[reviews_per_month]
  FROM [Sandbox].[dbo].[ABB_Listing]

/*
----- summary with dollar sign
--select  cast(replace(substring([price], 2,10), ',', '') as numeric(10,2)), count(*) from ABB_Listing
--group by cast(replace(substring([price], 2,10), ',', '') as numeric(10,2))
--order by 1 desc
---- other summary
select  [extra_people], count(*) from ABB_Listing
group by [extra_people]
order by 1 desc

*/