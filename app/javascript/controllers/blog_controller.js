// javascript/controllers/blog_controller.js
import { Controller } from "stimulus";
import Rails from "@rails/ujs";

import {objectToQueryString} from '../helpers'

export default class extends Controller {
    static targets = ["mainContainer", "blogTableContainer", "query", "perPage"];

    connect() {
        this.updateDataOnInitialLoad();
    }

    submitSeachQuery(event){
        let element = event.target;
        let tag = null;
        if(element && element.dataset.tag){
            tag = element.dataset.tag;
        }
        let queryObj = {
            per_page: this.perPageTarget.value,
            query: this.queryTarget.value,
            page: 1,
            tag: tag
        }

        if(queryObj.query){
            this.mainContainerTarget.dataset.query = queryObj.query
        }

        if(queryObj.per_page){
            this.mainContainerTarget.dataset.perPage = queryObj.per_page
        }

        let queryString = objectToQueryString(queryObj)
        this.dataRequest(queryString)
    }

    updateDataOnInitialLoad(){
        let step = this.mainContainerTarget.dataset.step
        let per_page = this.mainContainerTarget.dataset.perPage;
        let query = this.mainContainerTarget.dataset.query;
        let currentPage = null;
        if(this.blogTableContainerTarget){
            currentPage = this.blogTableContainerTarget.dataset.currentPage;
        }
        this.queryTarget.value = query ? query : ""
        this.perPageTarget.value = per_page ? per_page : 10
        let page = currentPage ? currentPage : 1

        let queryObj = {per_page, query, page}
        let queryString = objectToQueryString(queryObj)
        this.mainContainerTarget.dataset.step = "update"
        this.dataRequest(queryString)
    }

    dataRequest(query){
        Rails.ajax({
            type: 'get',
            url: `/authors/blog?${query}`,
        })
    }
}
