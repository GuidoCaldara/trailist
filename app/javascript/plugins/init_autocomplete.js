import places from 'places.js';

const initAutocomplete = () => {
  const addressInput = document.getElementById('organization_location');
  const raceLocation = document.getElementById('race_location');
  const userLocation = document.getElementById('user_location');

  if (addressInput) {
    places({ container: addressInput });
  }
  if (raceLocation) {
    const form = document.querySelector("#race-search-form")
    const placeInput = places({ container: raceLocation });
    placeInput.on('change', e => Rails.fire(form, "submit") );
    placeInput.on('clear', e => Rails.fire(form, "submit") );
  }
  if (userLocation) {
    places({ container: userLocation });
  }


};

export { initAutocomplete };
