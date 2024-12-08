import os
from datetime import datetime, timedelta

from airflow import DAG
from airflow.providers.postgres.operators.postgres import PostgresOperator

sql_script = '''
    CREATE TABLE IF NOT EXISTS presentation.airport_stats (
        id SERIAL PRIMARY KEY,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        business_date DATE NOT NULL,
        airport_code VARCHAR(10) NOT NULL,
        total_departures INT NOT NULL,
        total_revenue NUMERIC(10, 2) NOT NULL
    );

    DELETE FROM presentation.airport_stats
    WHERE business_date = DATE_TRUNC('day', NOW() - INTERVAL '1 DAY');

    WITH yesterday_airport_stats AS (
        SELECT 
            DATE(NOW() - INTERVAL '1 DAY') AS business_date,
            f.departure_airport AS airport_code,
            COUNT(f.flight_id) AS total_departures,
            SUM(tf.amount) AS total_revenue
        FROM 
            flights f
        JOIN 
            ticket_flights tf ON f.flight_id = tf.flight_id
        WHERE 
            f.scheduled_departure >= DATE_TRUNC('day', NOW() - INTERVAL '1 DAY') 
            AND f.scheduled_departure < DATE_TRUNC('day', NOW())
        GROUP BY 
            f.departure_airport
    )
    INSERT INTO presentation.airport_stats (
        business_date, airport_code, total_departures, total_revenue
    )
    SELECT * FROM yesterday_airport_stats;
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
    "update_airport_stats",
    default_args=DEFAULT_ARGS,
    catchup=False,
    schedule_interval="15 0 * * *", 
    max_active_runs=1,
    concurrency=1
) as dag:
    task = PostgresOperator(
        task_id="update_airport_stats",
        postgres_conn_id="postgres_master",  
        sql=sql_script,
    )

    task
