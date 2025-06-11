--1. Top 10 Most Reviewed Listings
SELECT id, name, number_of_reviews
FROM listings
ORDER BY number_of_reviews DESC
LIMIT 10;

--2. Average Room Type
SELECT room_type, AVG(price) AS avg_price
FROM listings
GROUP BY room_type
ORDER BY avg_price DESC;

--3. Listings Count by Neighbourhood
SELECT neighbourhood, COUNT(*) AS total_listings
FROM listings
GROUP BY neighbourhood
ORDER BY total_listIngs DESC;

--4.Monthly Availability (Calendar)
SELECT
  DATE_TRUNC('month', date) AS month,
  COUNT(*) FILTER (WHERE available = 't') AS available_days,
  COUNT(*) FILTER (WHERE available = 'f') AS unavailable_days
FROM calendar
GROUP BY month
ORDER BY month;

--5. Most Active Reviewers
SELECT reviewer_name , COUNT(*) as review_count
FROM reviews
GROUP BY reviewer_name
ORDER BY review_count DESC
LIMIT 10;

--6. Estimated Revenue 
SELECT
  l.id,
  l.name,
  COUNT(*) AS booked_days,
  l.price * COUNT(*) AS estimated_revenue
FROM listings l
JOIN calendar c ON l.id = c.listing_id
WHERE c.available = 'f'
  AND l.price IS NOT NULL
GROUP BY l.id, l.name, l.price
ORDER BY estimated_revenue DESC
LIMIT 10;

--7. What are the busiest times of the year to visit Seattle? By how much do prices spike?
SELECT 
  DATE_TRUNC('month', c.date) AS month,
  COUNT(*) AS bookings,
  AVG(l.price) AS avg_price
FROM calendar c
JOIN listings l ON c.listing_id = l.id
WHERE c.available = 'f'
GROUP BY month
ORDER BY month;

--8. Total Booked Days
SELECT 
  DATE_TRUNC('month', c.date) AS month,
  COUNT(*) AS total_booked_days
FROM calendar c
WHERE c.available = 'f'
GROUP BY month
ORDER BY month;

--9. 







