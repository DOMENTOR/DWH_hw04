import os
from datetime import datetime, timedelta

from airflow import DAG
from airflow.providers.postgres.operators.postgres import PostgresOperator

sql_script = '''
            CREATE TABLE IF NOT EXISTS presentation.frequent_flyer (
            id SERIAL PRIMARY KEY,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            business_date DATE NOT NULL,
            passenger_id INT NOT NULL,
            passenger_name VARCHAR(255) NOT NULL,
            flights_number INT NOT NULL,
            purchase_sum NUMERIC(10, 2) NOT NULL,
            home_airport VARCHAR(255),
            customer_group VARCHAR(10)
        );

        DELETE FROM presentation.frequent_flyer
        WHERE business_date = DATE_TRUNC('day', NOW() - INTERVAL '1 DAY');

        WITH yesterday_data AS (
            SELECT 
                DATE(NOW() - INTERVAL '1 DAY') AS business_date,
                CAST(t.passenger_id AS INT) AS passenger_id,  -- Приведение к INT
                t.passenger_name,
                COUNT(tf.flight_id) AS flights_number,
                SUM(tf.amount) AS purchase_sum,
                (
                    SELECT f.departure_airport
                    FROM ticket_flights tf2
                    JOIN flights f ON tf2.flight_id = f.flight_id
                    WHERE tf2.ticket_no = t.ticket_no
                    GROUP BY f.departure_airport
                    ORDER BY COUNT(f.flight_id) DESC, f.departure_airport ASC
                    LIMIT 1
                ) AS home_airport,
                CASE
                    WHEN RANK() OVER (ORDER BY SUM(tf.amount) DESC) <= 0.05 * COUNT(*) THEN '5'
                    WHEN RANK() OVER (ORDER BY SUM(tf.amount) DESC) <= 0.10 * COUNT(*) THEN '10'
                    WHEN RANK() OVER (ORDER BY SUM(tf.amount) DESC) <= 0.25 * COUNT(*) THEN '25'
                    WHEN RANK() OVER (ORDER BY SUM(tf.amount) DESC) <= 0.50 * COUNT(*) THEN '50'
                    ELSE '50+'
                END AS customer_group
            FROM 
                tickets t
            JOIN 
                ticket_flights tf ON t.ticket_no = tf.ticket_no
            GROUP BY 
                t.passenger_id, t.passenger_name, t.ticket_no
        )
        INSERT INTO presentation.frequent_flyer (
            business_date, passenger_id, passenger_name, flights_number, purchase_sum, home_airport, customer_group
        )
        SELECT * FROM yesterday_data;
'''

DEFAULT_ARGS = {
    'owner': 'the_boys',
    'depends_on_past': False,
    'start_date': datetime(2024, 12, 8),
    'email': None,
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 0,
    'retry_delay': timedelta(minutes=5),
    'execution_timeout': timedelta(minutes=120)
}

with DAG(
    "update_frequent_flyer_data",
    default_args=DEFAULT_ARGS,
    catchup=False,
    schedule_interval="5 0 * * *", 
    max_active_runs=1,
    concurrency=1
) as dag:
    task = PostgresOperator(
        task_id="update_frequent_flyer",
        postgres_conn_id="postgres_master", 
        sql=sql_script,
    )

    task
