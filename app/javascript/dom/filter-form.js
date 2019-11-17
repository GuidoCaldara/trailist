




  const btnDynamicColor = () => {
   const buttons = document.querySelectorAll(".race-type-selector")
   buttons.forEach((btn) =>{
      btn.addEventListener("click", (e) =>{
        e.currentTarget.classList.toggle("btn-outline-primary")
        e.currentTarget.classList.toggle("btn-primary")
      })
   })
  }


const initFilterForm = () =>{
  btnDynamicColor()
  const form = document.querySelector("#race-search-form")
  const inputs = document.querySelectorAll("#race-search-form input")
  inputs.forEach((input) =>{
    input.addEventListener("change", (e) =>{
      if (e.currentTarget.id !== "race_location") Rails.fire(form, "submit")
    })
  })
}


export { initFilterForm }
