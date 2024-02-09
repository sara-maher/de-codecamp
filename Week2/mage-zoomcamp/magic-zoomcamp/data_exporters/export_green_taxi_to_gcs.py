import pyarrow as pa
import pyarrow.parquet as pq
import os

from mage_ai.settings.repo import get_repo_path
from mage_ai.io.config import ConfigFileLoader
from mage_ai.io.google_cloud_storage import GoogleCloudStorage
from pandas import DataFrame
from os import path

if 'data_exporter' not in globals():
    from mage_ai.data_preparation.decorators import data_exporter

os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = '/home/src/creds.json'
bucket_name = 'mage-zoomcamp-thinking-land'
project_id = 'thinking-land-410514'
table_name = 'nyc_green_taxi_date'
root_path = f'{bucket_name}/{table_name}'


@data_exporter
def export_data_to_google_cloud_storage(df: DataFrame, **kwargs) -> None:
    """
    Template for exporting data to a Google Cloud Storage bucket.
    Specify your configuration settings in 'io_config.yaml'.

    Docs: https://docs.mage.ai/design/data-loading#googlecloudstorage
    """
    df['lpep_pickup_date'] = df['lpep_pickup_datetime'].dt.date
    table = pa.Table.from_pandas(df)
    gcs = pa.fs.GcsFileSystem()
    pq.write_to_dataset(table, root_path=root_path, partition_cols=['lpep_pickup_date'], filesystem=gcs)