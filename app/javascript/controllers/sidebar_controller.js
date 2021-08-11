// javascript/controllers/sidebar_controller.js
import { Controller } from "stimulus";

export default class extends Controller {

    static targets = ["sidebarMain", "itemsListContainer", "itemsList"]

    connect() {
        console.log(this)
        this.updateSideBarActiveItem()
    }

    closeSidebar() {
        let sideMain = this.sidebarMainTarget;
        let itemsListContainer = this.itemsListContainerTarget;
        if(sideMain){
            sideMain.classList.add('d-none')
            itemsListContainer.classList.remove('w-280')
            itemsListContainer.classList.add('w-0')
        }
    }

    openSidebar() {
        let sideMain = this.sidebarMainTarget;
        let itemsListContainer = this.itemsListContainerTarget;
        if(sideMain){
            sideMain.classList.remove('d-none')
            itemsListContainer.classList.remove('w-0')
            itemsListContainer.classList.add('w-280')
        }
    }

    updateSideBarActiveItem(){
        let pathname = location.pathname.split('/').filter(Boolean);
        let sidebarItems = document.querySelectorAll('.sidebar-item');
        let navbarItems = document.querySelectorAll('.navbar-item');
        this.activeItemMapper(pathname, sidebarItems, 'sidebar-item-active')
        this.activeItemMapper(pathname, navbarItems, 'navbar-item-active')
    }

    activeItemMapper(pathname, collection, class_name){
        collection.forEach(item => {
            let name = item.dataset.name;
            if(pathname.length > 0 && pathname.indexOf(name) >= 0){
                item.classList.add(class_name)
            }if(pathname.length === 0 && name === 'Home'){
                item.classList.add(class_name)
            }else {
                if(item.classList.contains(class_name)){
                    item.classList.remove(class_name);
                }
            }
        })
    }
}
