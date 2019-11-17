require("@rails/ujs").start()
//require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
import 'jquery'
import 'bootstrap'
import { initAutocomplete } from '../plugins/init_autocomplete'
import { initCalendar } from '../plugins/init_flatpickr'
import { photoPreview } from '../dom/photo_uploader';
import { initMapbox } from '../plugins/init_mapbox';
import { initFilterForm } from '../dom/filter-form';

initAutocomplete()
initCalendar()
photoPreview()
initFilterForm()
initMapbox();


  const addClass = (stars, target) =>{
    console.log("Adding")
    const selectedValue = parseInt(target)
    stars.forEach((star) => {
      const starValue = parseInt(star.dataset.value)
      if (starValue <= selectedValue) star.classList.add("selected")
    })
  }


 const removeClass = (stars) =>{
    stars.forEach((star) => {
      star.classList.remove('selected')
    })
 }

  const changeStars = async (e) => {
    const target = e.currentTarget.dataset.target
    const newValue = e.currentTarget.dataset.value
    const relatedStars = document.querySelectorAll(`[data-target='${target}'`)
    await removeClass(relatedStars);
    await addClass(relatedStars, newValue);
    document.querySelector(`#${target}`).value = newValue
}


  const stars = document.querySelectorAll(".single-star")
  stars.forEach((star) =>{
    star.addEventListener("click", changeStars)
  })
