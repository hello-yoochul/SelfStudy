# Advanced PostgreSQL

# CHAP 01: Obtain Summary Statistics by Grouping Rows

링크드인 러닝의 자료를 가지고 공부하였습니다. ([link](https://www.linkedin.com/learning/postgresql-advanced-queries))

## Docker 로 PostgreSQL 사용 환경 만들기 

참고 자료: [How to Run PostgreSQL and pgAdmin Using Docker](https://towardsdatascience.com/how-to-run-postgresql-and-pgadmin-using-docker-3a6a8ae918b5) 

```
mkdir pgAdmin
cd pgAdmin
gedit ./docker-compose.yml
```

yml 파일에 아래 복붙

```yml
version: '3.8'
services:
  db:
    container_name: pg_container
    image: postgres
    restart: always
    environment:
      POSTGRES_USER: root
      POSTGRES_PASSWORD: root
      POSTGRES_DB: test_db
    ports:
      - "5432:5432"
  pgadmin:
    container_name: pgadmin4_container
    image: dpage/pgadmin4
    restart: always
    environment:
      PGADMIN_DEFAULT_EMAIL: admin@admin.com
      PGADMIN_DEFAULT_PASSWORD: root
    ports:
      - "5050:80"
```

```
cd pgAdmin
docker-compose up
```

브라우저에서,

- http://localhost:5050/ 열기 
  - ID: admin@admin.com  
  - PW: root

PostgreSQL 서버의 IP 알아내기 

```
docker ps
```

![image](https://user-images.githubusercontent.com/49010295/165493795-700ec31f-c904-4538-bfd6-5857901b560e.png)

docker 컨테이너 ID inspect 해서 IP 주소 찾기

```
docker inspect 8b9e46616e8f | grep IPAddress
```

![image](https://user-images.githubusercontent.com/49010295/165493733-7b414e96-fe05-4a95-8a73-f21924e05384.png)

서버 만들기 Severs > Register > Server

![image](https://user-images.githubusercontent.com/49010295/165493679-56ee7914-4f88-4716-8c26-55e697a8cdb9.png)

이름 원하는데로 여기선 my_db

![image](https://user-images.githubusercontent.com/49010295/165493588-fad896d0-3eb7-4b09-aa11-09648f85bea1.png)

Connection 탭 클릭후 > docker inspect로 찾아온 IP 입력 > ID, PW 둘다 root 로 지정

![image](https://user-images.githubusercontent.com/49010295/165493443-7db09f49-f844-4388-b9b8-17e18bd3d0be.png)

서버 생성 완료

## DB 생성 후 더미 데이터 넣기

```sql
CREATE DATABSE two_trees
```

아래 Query Tool 누르면 SQL 작성 가능 

![image](https://user-images.githubusercontent.com/49010295/165493400-965843e7-ff26-41c3-a7bb-2978f3e346c0.png)

아래 파일 복붙 후 실행

[two_trees_database.txt](https://github.com/LARRYKIM1/SelfStudy/blob/main/PostgreSQL/two_trees_database.txt)

my_db > Databases > two_trees > Schemas 에서 생성 확인 

![image](https://user-images.githubusercontent.com/49010295/165493368-9d025e6d-9c1b-484d-951a-5147027a086b.png)

> ### TIP
>
> File > preferences > Browser > Nodes > Columns, Constraints, Databases, Indexes, Schemas, Tables 만 enable 하기 
>
> Servers > Refresh 하면, 깔끔
>
> ![image](https://user-images.githubusercontent.com/49010295/165493279-3a7de5ec-6438-47b4-8821-0fda666f85d2.png)

데이터 확인 (실행: F5)

```sql
SELECT * FROM inventory.categories;
SELECT * FROM inventory.products;

SELECT * FROM sales.customers;
SELECT * FROM sales.order_lines;
SELECT * FROM sales.orders;
```

```sql
SELECT * FROM inventory.categories;
```

```sql
SELECT * FROM inventory.categories;
SELECT * FROM inventory.products;

SELECT * FROM sales.customers;
SELECT * FROM sales.order_lines;
SELECT * FROM sales.orders;
```

데이터 확인

```sql
SELECT * FROM inventory.categories; -- 3 rows
```

![image](https://user-images.githubusercontent.com/49010295/165494247-a190c146-5223-4d69-a406-738132af2f47.png)

```sql
SELECT * FROM inventory.products; -- 114 rows
```

![image](https://user-images.githubusercontent.com/49010295/165494502-691b9e9c-fe7f-44ce-b44a-429188036680.png)

```sql
SELECT * FROM sales.customers; -- 6 rows
```

![image](https://user-images.githubusercontent.com/49010295/165494547-1be9f36f-2ba8-4626-b26c-ba749ab012bd.png)

```sql
SELECT * FROM sales.order_lines; -- 176 rows
```

![image](https://user-images.githubusercontent.com/49010295/165494770-e3a20579-4cc6-4d19-bdcb-56cd80fb5fd7.png)

```sql
SELECT * FROM sales.orders; -- 61 rows
```

![image](https://user-images.githubusercontent.com/49010295/165494748-efb9bfb1-687f-4d7c-bf5a-ff42774970fd.png)



## 문제 1 - where, group by, 

### 문제: 가격이 20 이상인 상품 이름, 카테고리 ID, 사이즈, 가격 가져오기  (inventory.products 테이블 사용)

결과 

![image](https://user-images.githubusercontent.com/49010295/165494975-c41971ad-aa16-4e1c-a28c-61ac5ed44a0a.png)

답:

```sql
select product_name, category_id, size, price
from inventory.products
where price > 20.00;
-- 37 rows
```

### 문제: 상품을 사이즈별로 개수를 세고 싶다. 

결과 

![image](https://user-images.githubusercontent.com/49010295/165495197-4bcc865d-f105-4e58-9517-d5d4663f8dcf.png)

답:

```sql
select size as "product size", count(*) as "number of products"
from inventory.products
group by size
having count(*) > 10
order by size DESC;
-- 5 rows
```

### 문제: 상품 이름 별 상품의 개수, highest 가격, lowest size, averagae 가격을 가져와 보자.  제품 이름은 중복된게 있음. (inventory.products  테이블 사용)

```
-- 테스트용 확인 코드
select sku, product_name, size, price
from inventory.products;
```

결과 

![image](https://user-images.githubusercontent.com/49010295/165495286-5ec0e1bf-d142-439d-9eb1-e47a9a262926.png)

답:

```sql
select sku, product_name, size, price
from inventory.products;

select product_name,
	count(*) as "number of products",
	max(price) as "highest price",
	min(price) as "lowest price",
	avg(price) as "average price"
from inventory.products
group by product_name;
-- 31 rows
```

### 문제: 지역 (state) 별로 뉴스레터를 구독한 사용자만 가져와라. (sales.customers  테이블 사용)

결과 

![image](https://user-images.githubusercontent.com/49010295/165495328-1108eaf3-3dd1-42ba-898e-398674c29812.png)

답:

```sql
select state, count(*), bool_and(newsletter), bool_or(newsletter)
from sales.customers
group by state
-- 4 rows
```

## 문제 2 - aggregate function, rollup, cube, filter

people_heights 테이블 만들기 
아래 쿼리 실행
[people_heights.txt](https://github.com/LARRYKIM1/SelfStudy/blob/main/PostgreSQL/people_heights.txt) 

### 문제: 남녀의 평균 키와 최소값 최대값 

결과 

![image](https://user-images.githubusercontent.com/49010295/165495420-6f2a1aa9-a6bd-4728-8bf0-fb2b2724d7b4.png)

답:

```sql
select gender, 
	count(*), 
	avg(height_inches), 
	min(height_inches), 
	max(height_inches)
from public.people_heights
group by gender 
-- 2 rows
```

### 문제: 다음 코드의 의미는?

```sql
select gender, 
    stddev_samp(height_inches),
    stddev_pop(height_inches),
    var_samp(height_inches),
    var_pop(height_inches)
from public.people_heights
group by gender
-- 2
```

![image](https://user-images.githubusercontent.com/49010295/165495473-f9c6c2b1-ceb6-42bc-a4b9-63c7ce7a305e.png)

답: [DOC 확인](https://www.postgresql.org/docs/9.1/functions-aggregate.html)

### 문제: inventory.products 에서 rollup 사용해보기

결과 

![image](https://user-images.githubusercontent.com/49010295/165492772-d8894e1f-e25a-422a-8913-f6e68d8dce08.png)

예시 답:

```sql
select category_id,
	product_name,
	count(*),
	min(price) as "lowest price",
	max(price) as "highest price",
	avg(price) as "average price"
from inventory.products
group by rollup (category_id, product_name)
order by category_id, product_name;
-- 35 rows
```

### 문제: inventory.products 에서 cube 사용해보기

결과 

![image](https://user-images.githubusercontent.com/49010295/165493074-09777300-958e-4707-b644-e13b362c36b6.png)

예시 답:

```sql
select category_id,
	size,
	count(*),
	min(price) as "lowest price",
	max(price) as "highest price",
	avg(price) as "average price"
from inventory.products
group by cube (category_id, size)
order by category_id, size;
-- 24 rows
```

### 문제: 카테고리 id 별 개수,  평균 가격, 사이즈 16 보다 작은 상품 개수,  사이즈 16 보다 작은 상품 평균 가격 ~. 아래와 같은 결과 만들기 (filter 사용)

![image](https://user-images.githubusercontent.com/49010295/165496374-ef451d24-156e-4b00-b741-ea04ff3893c9.png)

답:

```sql
select category_id,
	count(*) as "count all",
	avg(price) as "average price",
	-- small products
	count(*) filter (where size <=16) as "count small",
	avg(price) filter (where size <= 16) as "average price small",
	-- large products
	count(*) filter (where size >16) as "count large",
	avg(price) filter (where size >16) as "average price large"
from inventory.products
group by rollup (category_id)
order by category_id
-- 4 rows
```

### 문제: 고객들의 3, 4월의 주문 개수  

![image](https://user-images.githubusercontent.com/49010295/165497151-f48d4fde-8a36-4c9b-8b17-cf10b1f76a00.png)

답:

```sql
select customer_id,
	count(*) filter (where order_date >= '2021-03-01' and order_date <= '2021-03-31') as "March",
	count(*) filter (where order_date between '2021-04-01' and '2021-04-30') as "April"
from sales.orders
group by customer_id;
-- 6 rows
```

### 문제: 판매된 제품의 수량  (sales.order_lines 테이블 사용)

결과 

![image](https://user-images.githubusercontent.com/49010295/165497579-95c7ff44-f2a3-4727-8245-a3cef7c85f55.png)

답:

```sql
select sku, sum(quantity) as "Total Sold"
from sales.order_lines
group by rollup (sku)
order by sum(quantity) DESC;
-- 50 rows
```

# CHAP 02: Use Window Functions to Perform Calculations across Row Sets

## 예 1

```sql
select sku,
	product_name,
	size,
	category_id,
	price,
	avg(price) over(partition by size) as "average price for size",
	price - avg(price) over(partition by size) as "difference"
from inventory.products
order by sku, size;
-- 114 rows 
```

![image](https://user-images.githubusercontent.com/49010295/165501413-7bf482c8-931c-4a13-a8fa-f4de7c013c37.png)

## 예 2

- xyz: alias 같은 느낌 

```sql
select sku,
	product_name,
	category_id,
	size,
	price,
	avg(price) over (xyz),
	min(price) over (xyz),
	max(price) over (xyz)
from inventory.products
window xyz as (partition by category_id)
order by sku, size;
-- 114 rows
```

![image](https://user-images.githubusercontent.com/49010295/165501695-dbd33b2e-ebb7-4169-969e-8fbf5157a69d.png)

## 예 3

- line total: 주문에서 특정 제품 가격 합 
- order total: 주문의 모든 제품 가격 합 

```sql
select order_lines.order_id,
	order_lines.line_id,
	order_lines.sku,
	order_lines.quantity,
	products.price as "price each",
	order_lines.quantity * products.price as "line total",
	sum (order_lines.quantity * products.price)
		over (partition by order_id) as "order total",
	sum (order_lines.quantity * products.price)
		over (partition by order_id order by line_id) as "running total"
from sales.order_lines inner join inventory.products
	on order_lines.sku = products.sku;
```

![image](https://user-images.githubusercontent.com/49010295/165576438-000f7daf-e7e4-40bf-b263-df4486d1f3a4.png)

## 예 4

- between 0 preceding and 2 following: 뒤에 0개 앞에 2개 더한 것. 
  - 즉, 101이 었을때, 101 + 102 + 103 이 됨

```sql
select order_id,
    sum(order_id) over (order by order_id rows between 0 preceding and 2 following)
        as "3 period leading sum",
    sum(order_id) over (order by order_id rows between 2 preceding and 0 following)
        as "3 period trailing sum",
    avg(order_id) over (order by order_id rows between 1 preceding and 1 following)
        as "3 period moving average"
from sales.orders;
```

![image](https://user-images.githubusercontent.com/49010295/165502083-63d52869-ea68-4efd-9486-5750b6a63d07.png)

## 예 5 - first_value( ), last_value( )

- first_value: 첫번째 값
- last_value: 마지막 값
- nth_value: 특정 위치 값
- unbounded로 모든 위치 지정해야됨. 
  - `last_value(company) over(order by company)`  만 하면 값이 이상하게 나옴. (뒤에 로우 들은 무시되기 때문)

```sql
select company,
	first_value(company) over(order by company
		rows between unbounded preceding and unbounded following),
	last_value(company) over(order by company
		rows between unbounded preceding and unbounded following),
	nth_value(company, 3) over(order by company
		rows between unbounded preceding and unbounded following)
from sales.customers
order by company;
```

![image](https://user-images.githubusercontent.com/49010295/165576717-08f54b56-8014-46d2-acd2-984988ccf783.png)

## 예 6

- 고객의 첫번째 주문일과 최근 주문일 가져올때, first_value와 last_value 유용

```sql
select distinct customer_id,
	first_value(order_date)
		over (partition by customer_id
			 order by order_date
			 rows between unbounded preceding and unbounded following),
	last_value(order_date)
		over (partition by customer_id
			 order by order_date
			 rows between unbounded preceding and unbounded following)
from sales.orders
order by customer_id;
```

![image](https://user-images.githubusercontent.com/49010295/165502288-f7d78119-078c-4c73-b91b-dc9830ea3e20.png)

## Challenge

![image](https://user-images.githubusercontent.com/49010295/165582377-d51d0569-4897-4f91-b4f7-dd6ed2bc7fa1.png)

- 카테고리 id의 사이즈별로 조사할때

```sql
select category_id, product_name, size, price,
	max(price) over(w),
	min(price) over(w),
	avg(price) over(w),
	count(*) over(w)
from inventory.products
window w as (partition by category_id, size)
order by category_id, product_name, size;
```

![image](https://user-images.githubusercontent.com/49010295/165503719-69f7a3da-caba-4cfa-83ac-8dd401c10f66.png)

# CHAP 03: Statistics Based on Sorted Data within Groups

## 예 1 - percentile_disc( ), percentile_cont( )

- [링크](https://leafo.net/guides/postgresql-calculating-percentile.html)
  - `percentile_disc` will return a value from the input set closest to the percentile you request
  - `percentile_cont` will return an interpolated value between multiple values based on the distribution. You can think of this as being more accurate, but can return a fractional value between the two values from the input

```sql
select gender,
    percentile_disc(0.5) within group (order by height_inches) as "discrete median",
    percentile_cont(0.5) within group (order by height_inches) as "continuous median"
from public.people_heights
group by rollup (gender);
```

![image](https://user-images.githubusercontent.com/49010295/165579586-1c701526-f2d0-4577-97c1-a619cc57b372.png)

## 예 2 - percentile_cont( )

```sql
select
    percentile_cont(.25) within group (order by height_inches) as "1st quartile",
    percentile_cont(.50) within group (order by height_inches) as "2nd quartile",
    percentile_cont(.75) within group (order by height_inches) as "3rd quartile"
from public.people_heights;
```

## 예 3 - mode( )

- mode() 제약 
  - 주의: 다른 동일한 값이 있음에도 1개만 리턴

```sql
select
	mode() within group (order by height_inches)
from public.people_heights;

select height_inches, count(*)
from public.people_heights
group by height_inches
order by count(*) desc;
```

## Challange

## ![image](https://user-images.githubusercontent.com/49010295/165582071-cd09abed-c7bc-4984-9ae7-9ba53c135052.png)

```sql
-- Obtain statistical information about product pricing
select category_id,
	min(price) as "min price",
	percentile_cont(.25) within group (order by price) as "1st quartile",
	percentile_cont(.50) within group (order by price) as "2nd quartile",
	percentile_cont(.75) within group (order by price) as "3rd quartile",
	max(price) as "max price",
	max(price) - min(price) as "price range"
from inventory.products
group by rollup (category_id);
```

​              

# CHAP 4: Ranking Data with Windows and Hypothetical Se ts

## 예 1 - rank(), dense_rank( )

```sql
-- ranking with window functions
select name, height_inches, gender,
	rank() over (partition by gender order by height_inches desc),
	dense_rank() over (partition by gender order by height_inches desc)
from public.people_heights
order by gender, height_inches desc;
```

## 예 2 - hypothetical grouping set aggregate

- 키가 70 인치인 사람을 남녀 각각으로 넣어봤을 때 순위 (hypothetical)

```sql
-- using rank as a hypothetical grouping set aggregate
select name, height_inches
from public.people_heights
order by height_inches desc;

select gender,
	rank(70) within group (order by height_inches desc)
from public.people_heights
group by rollup (gender);
```

## 예 3 - percent_rank( )

- 백분위 랭크

```sql
select name, gender, height_inches,
	percent_rank() over (order by height_inches desc),
	case
		when percent_rank() over (order by height_inches desc) < .25 then '1st'
		when percent_rank() over (order by height_inches desc) < .50 then '2nd'
		when percent_rank() over (order by height_inches desc) < .75 then '3rd'
		else '4th'
	end as "quartile rank"
from public.people_heights
order by height_inches desc;
```

## 예 4 - cume_dist( )

- The **CUME_DIST**() function returns the cumulative distribution of a value within a set of values.
- percent_rank이랑 거의 비슷 (차이는 percent_rank는 계산에 본인 로우를 포함 x)

```sql
select name, height_inches,
	percent_rank() over (order by height_inches desc),
	cume_dist() over (order by height_inches desc)
from public.people_heights
order by height_inches desc;
```

## Challenge 

```sql
-- rank product pricing overall, by category, and by size

select product_name, category_id, size, price,
	dense_rank() over (order by price desc) as "rank overall",
	dense_rank() over (partition by category_id order by price desc) as "rank category",
	dense_rank() over (partition by size order by price desc) as "rank price"
from inventory.products
order by category_id, price desc;
```

# CHAP 5: Define Output Values with Conditional Expressions

## 예 1 - CASE

```sql
select sku, product_name, category_id,
	case
		when category_id = 1 then 'Olive Oils'
		when category_id = 2 then 'Flavor Infused Oils'
		when category_id = 3 then 'Bath and Beauty'
		else 'category unknown'
	end as "category description",
	size, price
from inventory.products;
```

## 예 2 - coalesce( )

```sql
select * from inventory.categories;

insert into inventory.categories values
(4, null, 'Gift Baskets');

select category_id,
	-- category_description이 널이면 product_line 값으로 대체
	coalesce(category_description, product_line) as "description",
	product_line
from inventory.categories;
```

## 예 3 - nullif( )

```sql
select nullif('A', 'A');

select * from inventory.products;

select sku, product_name, category_id,
	-- 사이즈가 32면 null 로 표기
	nullif(size, 32) as "size",
	price
from inventory.products;
```

# CHAP 6: Additional Querying Techniques for Common Problems

## 예 1 - row_number( )

```sql
select * from inventory.products;

select sku, product_name, size,
	row_number() over (partition by product_name order by sku)
from inventory.products;
```

## 예 2 - 타입 바꾸기

```sql
select order_id,
	order_date::text,
	customer_id
from sales.orders;
```

## 예 3 - lag( ), lead( )

- [계층형 쿼리](https://devdhjo.github.io/sqld/2019/11/26/database-sqld-020.html)랑 비슷한듯

```sql
select order_id,
	customer_id,
	order_date,
	lag(order_date, 1) over(partition by customer_id order by order_id)
		as "previous order date",
	lead (order_date, 1) over(partition by customer_id order by order_id)
		as "next order",
	lead (order_date, 1) over(partition by customer_id order by order_id) -
		order_date as "time between orders"
from sales.orders
order by customer_id, order_date;
```

## 예 4 - IN 

```sql
-- us an in() function with a list
select *
from inventory.products
where product_name in('Delicate', 'Bold', 'Light');

-- use an in function with a sub select query
select *
from inventory.products
where product_name in(
		select product_name
		from inventory.products
		group by product_name
		having count(*) >= 5
);

-- determine the query used as a sub select above
select product_name, count(*)
from inventory.products
group by product_name
having count(*) >= 5;
```

## 예 5 - generate_series( )

```sql
select generate_series(100,120);
select generate_series(100,120,5);

-- 0~10000 시리즈 안에 주문 찾기 (10 단위)
select * 
from sales.orders
where order_id in(
	select generate_series(0,10000,10)	
)
order by order_id;

select * 
from sales.orders
where order_date in(
    -- 텍스트를 타임스탬프로 변경
	select generate_series('2021-03-15'::timestamp, '2021-03-31'::timestamp, '5 days')	
)
order by order_id;
```

## Challenge

![image](https://user-images.githubusercontent.com/49010295/165636894-ed363ffc-f810-4665-b1aa-35a4db47687d.png)

```sql
select person_id,
	name,
	height_inches,
	lag(name, 1) over (order by height_inches) as "is taller than",
	height_inches - lag(height_inches, 1) over (order by height_inches)
		as "by this many inches"
from public.people_heights
order by height_inches desc;              
```

# QUIZ

## 1

- Which SQL clause is used to filter groups from a result set?
  - HAVING
- Aggregate functions can be applied to a subset of the data using what keyword?
  - FILTER
- Which of these GROUP BY clauses will display subtotal and grand total rows?
  - GROUP BY ROLLUP (dept_name, emp_id)
- Which keyword, when added to a GROUP BY clause, will return all possible combination of grouping parameters?
  - CUBE
- The BOOL_AND() function will return 'true' under which circumstance?
  - All rows are true.
- Standard deviation and Variance are ways to describe what aspect of a data set?
  - 	Distribution
- In order to use the `max()`, `min()`, or `avg()` functions in a SELECT clause, what other clause does your query need to have?
  - GROUP BY
    - These three aggregate functions compute values from a group of records.

## 2

- Which keyword can be used with `between _____ preceding and _____ following` to create a sorted window frame that contains all rows?
  - 	unbounded
- You have a column of values named 'data' that contains the numbers 10,  20, 30. What would be the result of this window function?   `avg(data) over (order by data)`
  - 10, 15, 20
    - The ORDER BY clause in the OVER clause causes the window function to  operate only on rows up to and including the current row in the frame.
- Which of these will create a five period moving average of the daily stock price data?
  - avg(stock_price) over (order by date rows between 2 preceding and 2 following)'	
    - This window function would average the current price with the two previous and two subsequent days.
- You have a data table that stores information about a wide variety of  animals and their weights. Which window function will return the average weight for each species?
  - avg(weight) over (partition by species) 
    - Creating segments within the window frame requires the PARTITION BY keywords.
- Why would you add a window clause to a query?
  - to create a window frame that's used by several window functions
- Which clause turns an aggregate function into a window function?
  - OVER()

## 3

- What does the PostgreSQL RANGE() function do?
  - There is no RANGE() function in PostgreSQL.
- What does the NTIL() function do?
  - It separates the data into equal groups. '
    - The NTIL() function only creates groups with an equal number of rows. It does not evaluate tied values.
- What is the mode of a data set?
  - the value that occurs the most number of times
    - Be aware that the PostgreSQL MODE() function only returns one of these  values if there are more than one with the same number of occurrences.
- Which of these describes a continuous median?
  - For datasets with an even number of data points, a continuous median will sort the data, then average the two middle values.

## 4

- Which value will the PERCENT_RANK() function never return?
  - 1.5
    - PERCENT_RANK returns a percentage value that will always be between 0 and 1.
- Which of these best describes the output of the cumulative distribution function CUME_DIST()?
  - the row's sorted position, divided by the number of rows in the data set 
- Which of these is NOT true about the PostgreSQL ranking functions?
  - DENSE_RANK() will assign different ranks to rows with the same input value.
- Given the data set 'my_numbers' with the values 10, 20, 30, 40, 50, what would be the result of this function? `select rank (28) within group (order by my_numbers desc) from dataset`
  - 4

## 5

- Which component is an optional part of a CASE statement?
  - ELSE
- What is the result of this query?  `select coalesce('X', null, 'Z');`
  - X
- What is the purpose of the NULLIF() function?
  - It turns non-null values into null.

## 6

- In order to use a sub select query within an IN() function, what criteria must be met?

  - The sub select query must return a single column. 

- What data types can be passed into the GENERATE_SERIES() function?

  - numeric or timestamp

- Which symbols are used to cast values from one data type to another in PostgreSQL

  - ::

- You have a column of values named 'data' that contains the numbers 10,  20, 30, 40, 50. What would be the result of this function? `lag(data, 1) over (order by data)`

  - null, 10, 20, 30, 40

- The ROW_NUMBER() function requires which additional clause?

  - OVER









































