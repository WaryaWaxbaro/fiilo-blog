// javascript/controllers/tag_controller.js
import { Controller } from "stimulus";
import Rails from '@rails/ujs';

export default class extends Controller {
    static targets = ['tagsContainer', 'tagForm', 'availableTags'];

    connect(){
        //this.tagsList()
    }

    tagsList(){
        let controller = this;

        Rails.ajax({
            type: 'get',
            url: `/authors/tags.json?post_id`,
            success: function (response){
                console.log({response})
                let tags = response;
                controller.tagsListItems(tags)
            }
        })
    }

    showAvailableTags(event){
        event.preventDefault();
        let controller = this;
        let post_id = document.getElementById('tags_post_id').value
        let element = event.target;
        Rails.ajax({
            type: 'get',
            url: `/authors/tags.json?post_id=${post_id}&query=${element.value}`,
            success: function (response){
                console.log('success ', response)
                let tags = response;
                controller.availableTagsTarget.innerHTML = "";
                if(controller.availableTagsTarget.classList.contains('d-none')){
                    controller.availableTagsTarget.classList.remove('d-none')
                }
                let allListItems = ""
                if(tags && tags.length > 0){
                    tags.forEach(tag => {
                        let listItem = `<li class="p-2 border-bottom"><button data-tag-id="${tag.id}" data-action="tags#updatePostTags" class="btn bg-transparent h-100 w-100 p-0 m-0 text-start">${tag.name}</button></li>`
                        allListItems += listItem;
                    })
                    controller.availableTagsTarget.innerHTML = allListItems
                }else {

                }
            },
            error: function (response){
                console.log('error ', response)
            }
        })
    }

    updatePostTags(event){
        let post_id = document.getElementById('tags_post_id').value
        let element = event.target;
        let tagId = element.dataset.tagId
        let formData = new FormData();
        formData.append('post_id', post_id)
        formData.append('id', tagId)
        Rails.ajax({
            type: 'put',
            data: formData,
            url: `/authors/tags/${tagId}`,
            success: function (response){
                console.log(response)
            },
            error: function (response){
                console.log(response)
            }
        })
    }

    addNewTag(event){
        event.preventDefault();
        let form = this.tagFormTarget;
        let tagFormDate = new FormData(form)
        if(tagFormDate){
            Rails.ajax({
                type: 'post',
                data: tagFormDate,
                url: '/authors/tags',
                success: function (response){
                    console.log('success ', response)
                },
                error: function (response){
                    console.log('error ', response)
                }
            })
        }
    }

    removeTag(event){
        let element = event.target;
        let tag_id = element.dataset.tagId;
        let post_id = document.getElementById('tags_post_id').value

        if(tag_id){
            Rails.ajax({
                type: 'delete',
                url: `/authors/tags/${tag_id}?post_id=${post_id}`,
                success: function (response){
                    console.log('success ', response)
                },
                error: function (response){
                    console.log('error ', response)
                }
            })
        }
    }

    deleteTagFromList(){}

    tagsListItems(tags){
        let tags_list = ""
        if(tags && tags.length > 0){
            tags.forEach(tag => {
                let tag_element = `<div class="d-flex p-1 border me-1 mb-1">
                                        <span class="d-block me-3">${tag.name}</span>
                                        <button class="btn bg-transparent border-0 p-0 m-0"
                                        data-action="tags#removeTag" 
                                        data-tag-id="${tag.id}"><i class="fas fa-times pe-none"></i></button>
                                      </div>`
                tags_list += tag_element;
            })
        }

        this.tagsContainerTarget.innerHTML = tags_list;
    }
}
