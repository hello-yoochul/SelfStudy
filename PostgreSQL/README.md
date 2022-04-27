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

- 

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

## 예 5

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

## 예 7

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





































