// javascript/controllers/comments_controller.js
import { Controller } from "stimulus";

export default class extends Controller {
    static targets = ["mainContainer", "blogTableContainer", "query", "perPage"];

    toggleComment(event){
        let element = event.target;
        let id = element.dataset.id
        let commentContainer = document.getElementById(`comment-${id}`)
        let formContainer = document.getElementById(`edit-form-${id}`)
        commentContainer.classList.remove('d-none')
        commentContainer.classList.remove('invisible')
        formContainer.classList.add('d-none')
        formContainer.classList.add('invisible')
    }

    toggleEditForm(event){
        let element = event.target;
        let id = element.dataset.id
        let commentContainer = document.getElementById(`comment-${id}`)
        let formContainer = document.getElementById(`edit-form-${id}`)
        commentContainer.classList.add('d-none')
        commentContainer.classList.add('invisible')
        formContainer.classList.remove('d-none')
        formContainer.classList.remove('invisible')
    }
}
