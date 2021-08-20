// javascript/controllers/home_controller.js
import { Controller } from "stimulus";
import Rails from "@rails/ujs";

import {objectToQueryString} from '../helpers'

export default class extends Controller {
    static targets = ["mainContainer", "homePostsContainer", "query", "perPage", "queryColumn"];

    connect() {
        this.updateDataOnInitialLoad();
    }

    submitSeachQuery(event){
        //event.preventDefault();
        let element = event.target;
        let tag = null;
        if(element && element.dataset.tag){
            tag = element.dataset.tag;
            localStorage.setItem('tag', tag)
        }

        let queryObj = {
            per_page: 15,
            query: this.queryTarget.value,
            page: 1,
            tag: tag
        }

        if(queryObj.query){
            this.mainContainerTarget.dataset.query = queryObj.query
        }

        let queryString = objectToQueryString(queryObj)
        this.dataRequest(queryString)
    }

    removeActiveTag(event){
        let active_item = document.getElementById('home-active-selected-tag');
        if(active_item){
            active_item.remove();
        }
        localStorage.removeItem('tag')
        this.dataRequest("")
    }

    updateDataOnInitialLoad(){
        let step = this.mainContainerTarget.dataset.step
        let per_page = this.mainContainerTarget.dataset.perPage;
        let query = this.mainContainerTarget.dataset.query;
        let tag = localStorage.getItem('tag')
        if(tag){
            let tag_element = `<p id="home-active-selected-tag" class="d-flex align-items-center">
            Active tag: <span class="d-block d-flex align-items-center border p-1 rounded-3 ms-1 ">
            <span class="d-block ms-1 me-2" data-home-target="activeTag">${tag}</span>
            <button data-action="home#removeActiveTag" class="btn bg-transparent border-0 p-0"><i class="fas fa-times"></i></button>
          </span>
          </p>`
            this.queryColumnTarget.insertAdjacentHTML("beforeend", tag_element);
        }
        let currentPage = null;
        if(this.homePostsContainerTarget){
            currentPage = this.homePostsContainerTarget.dataset.currentPage;
        }
        this.queryTarget.value = query
        let page = currentPage

        let queryObj = {per_page, query, page, tag}
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
