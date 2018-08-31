global class ${NAME} extends DataSource.Connection {

    override global List<DataSource.TableResult> search(DataSource.SearchContext searchContext) {
        // to do
        return DataSource.SearchUtils.searchByName(searchContext, this);
    }
    override global List<DataSource.Table> sync() {
    
        List<DataSource.Column> columns = new List<DataSource.Column>();
        columns.add(DataSource.Column.text('ExternalId', 255));
        columns.add(DataSource.Column.url('DisplayUrl'));
        
        List<DataSource.Table> tables = new List<DataSource.Table>();
        tables.add(DataSource.Table.get('Properties', 'Name', columns));
        
        return tables;
    }

    override global DataSource.TableResult query(DataSource.QueryContext queryContext) {
    
        List<Map<String, Object>> records = DataSource.QueryUtils.process(
            queryContext,
            getRecords()
        );
        DataSource.TableResult tableResult = DataSource.TableResult.get(queryContext, records);
        
        return tableResult;
    }
    public List<Map<String, Object>> getRecords() {
    
        Http httpProtocol = new Http();
        HttpRequest request = new HttpRequest();
        String url = 'https://URL/';
        request.setEndPoint(url);
        request.setMethod('GET');
        
        HttpResponse response = httpProtocol.send(request);
        
        List<Map<String, Object>> records = new List<Map<String, Object>>();
        for (Object item : (List<Object>)JSON.deserializeUntyped(response.getBody())) {
            Map<String, Object> record = (Map<String, Object>)item;
            record.put('ExternalId', record.get('id'));
            record.put('DisplayUrl', 'URL/');
            record.put('Name', record.get('title'));
            records.add(record);
        }
        
        return records;
    }

}
 