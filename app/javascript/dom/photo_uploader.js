function previewImages() {

  var preview = document.querySelector('#preview');
  preview.innerHTML = ""
  if (this.files) {
    [].forEach.call(this.files, readAndPreview);
  }

  function readAndPreview(file) {

    // Make sure `file.name` matches our extensions criteria
    if (!/\.(jpe?g|png|gif)$/i.test(file.name)) {
      return alert(file.name + " is not an image");
    } // else...

    var reader = new FileReader();

    const card = document.querySelector(".photo-form-card-small")
    const btn = document.querySelector('#new_race_photo input[type="submit"]')
    reader.addEventListener("load", function() {
      var image = new Image();
      image.height = 40;
      image.title  = file.name;
      image.src    = this.result;
      preview.appendChild(image);
    });

    reader.readAsDataURL(file);
    btn.style.display = 'block'
  }
}

const previewLogo = (event) => {
  var reader = new FileReader();
  reader.onload = function(){
    var output = document.getElementById('logo-preview');
    output.src = reader.result;
    output.classList.add("mt-2")
  };
  reader.readAsDataURL(event.target.files[0]);
};



const photoPreview = () => {
  const newRaceInput = document.querySelector('#race_photo_picture')
  const orgLogo = document.querySelector('#organization_logo')
  if(newRaceInput){
    newRaceInput.addEventListener("change", previewImages);
  }
  if (orgLogo){
    orgLogo.addEventListener("change", previewLogo);
  }
}


export { photoPreview }
