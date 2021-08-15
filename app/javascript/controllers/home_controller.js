// javascript/controllers/home_controller.js
import { Controller } from "stimulus";
import Rails from "@rails/ujs";

import {objectToQueryString} from '../helpers'

export default class extends Controller {
    static targets = ["mainContainer", "homePostsContainer", "query", "perPage"];

    connect() {
        this.updateDataOnInitialLoad();
    }

    submitSeachQuery(event){
        let queryObj = {
            per_page: 15,
            query: this.queryTarget.value,
            page: 1
        }

        if(queryObj.query){
            this.mainContainerTarget.dataset.query = queryObj.query
        }

        let queryString = objectToQueryString(queryObj)
        this.dataRequest(queryString)
    }

    updateDataOnInitialLoad(){
        let step = this.mainContainerTarget.dataset.step
        let per_page = this.mainContainerTarget.dataset.perPage;
        let query = this.mainContainerTarget.dataset.query;
        let currentPage = null;
        if(this.staffTableContainerTarget){
            currentPage = this.staffTableContainerTarget.dataset.currentPage;
        }
        this.queryTarget.value = query ? query : ""
        let page = currentPage ? currentPage : 1

        let queryObj = {per_page, query, page}
        let queryString = objectToQueryString(queryObj)
        this.mainContainerTarget.dataset.step = "update"
        this.dataRequest(queryString)
    }

    dataRequest(query){
        Rails.ajax({
            type: 'get',
            url: `/?${query}`,
        })
    }
}
