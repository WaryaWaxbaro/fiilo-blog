import queryString from 'query-string'

export function queryStringToObj(searchLocation){
    return queryString.parse(searchLocation);
}

export function objectToQueryString(obj){
    for(let key in obj){
        if(!obj[key]){
            delete obj[key]
        }
    }
    return queryString.stringify(obj);
}