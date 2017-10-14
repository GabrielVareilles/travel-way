
function cardTemplate (activity) {
  return `
  <div class="col-md-4 col-sm-6 portfolio panel all ${activity.category} animated fadeIn">
  <div class="card-setactivity">
  <div class="panel-body">
  <div class="portfolio-title">
  <div class="portfolio-icon">
  <div>${activity.category.charAt(0).toUpperCase()}</div>
  </div>
  <div class="title">
  <h4><input type="checkbox" class="checkbox" name="trip[activity_ids][]" value="${activity.id}">${activity.name}</h4>
  </div>
  </div>
  </div>
  <div class="activities-portfolio-image" style="background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.2)), url('${activity.image_url}');">
  </div>
  </div>
  <div data-yelp-id="${activity.yelp_id}">
  <a class="details-link" data-toggle="modal" data-target="#info-${activity.yelp_id}">See details</a>
  </div>
  </div>

  <!--  Modal -->
  <div class="modal fade" id="info-${activity.yelp_id}" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog">
  <div class="modal-content">
  <button type="button" class="modal-close-btn" data-dismiss="modal" aria-label="Close"><span class="glyphicon glyphicon-remove"></span></button>
  <div class="modal-body container-fluid portfolio mobile">
  <!--  Carousel -->
  <div id="carousel-portfolio-2" class="carousel slide" data-ride="carousel">
  <div class="carousel-inner" role="listbox">
  <div class="item active">
  <img src="${activity.image_url}" alt="" />
  </div>
  </div>
  </div>
  <div class="row">
  <div class="col-md-5">
  <div class="infos">
  <div class="portfolio-title">
  <div class="portfolio-icon">
  <div>${activity.category.charAt(0).toUpperCase()}</div>
  </div>
  <div class="title">
  <h4>${activity.name}</h4>
  <em>${activity.category}</em>
  </div>
  </div>
  <div class="info-list">
  <ul>
  <li><i class="fa fa-phone" aria-hidden="true"></i>${activity.display_phone}</li>
  <li><i class="fa fa-map-marker" aria-hidden="true"></i>${activity.display_address}</li>
  </ul>
  </div>
  </div>
  </div>
  <div class="modal-text col-md-7">
  <p><table id="${ activity.id }-reviews"></table></p>
  </div>
  </div>
  </div>
  </div>
  </div>
  </div>



  `
}

function buttonTemplate(city, category) {
  return `
  <button type="button" class="allFilter btn background-black filter-selected animated fadeInLeft" onclick="filterCategories('${city}', '${category}')">${category}</button>
  `
}

function fetchReviews(yelp_id) {
  const reviewList = document.querySelector(`#info-${yelp_id} table`)
  fetch(`/fetchreviews?yelp_id=${yelp_id}`, { credentials: "same-origin" })
  .then(response => response.json())
  .then(results => {
    if (reviewList.innerHTML === "") {
      results.reviews.forEach((review) => {
        reviewList.insertAdjacentHTML("beforeend", `<tr class="review"><td><div class="image-cropper"><img src="${review.user.image_url}"></div></td><td class="review-text"><b>${review.user.name}:</b> ${review.text}</td></tr>`);
      });
    };
  });
};



function fetchActivitiesForPlace (city, callback) {
  const timeline = document.getElementById('timeline');
  const list = timeline.querySelector(`#${city} .activities-list`);
  const categoriesList = timeline.querySelector(`#${city} .categories-list .portfolio-filters`);

  fetch(`/search?place=${city}`, { credentials: "same-origin" })
  .then(response => response.json())
  .then(results => {
    list.innerHTML = '';
    let chosenActivities = 0;
    results.activities.forEach((activity, index) => {
      setTimeout(() => {
        list.insertAdjacentHTML('beforeend', cardTemplate(activity));
        let link = document.querySelectorAll(`#${city} .details-link`)[index]
        link.addEventListener("click", (event) => {
          const yelp_id = event.target.parentNode.dataset.yelpId;
          fetchReviews(yelp_id);
        });
        const card = link.parentNode.parentNode.querySelector('.card-setactivity');
        clickable(card);
      }, 150 * index);
    });

    results.categories.forEach((category, index) => {
      setTimeout(() => {
        categoriesList.insertAdjacentHTML('beforeend', buttonTemplate(city, category));
      }, 150 * index)
    });
  });
};

$(() => {
  const timeline = document.getElementById('timeline');
  if (timeline) {
    JSON.parse(timeline.dataset.places).forEach((place) => {
      fetchActivitiesForPlace(place);
    })
  }
})

const numberOfDays = parseInt(document.querySelector("#number_of_days").innerText);
console.log(numberOfDays);
let chosenActivities = 0;

function grey() {
  document.querySelectorAll(".card-setactivity:not(.selected-card)").forEach( (card) => {
    card.classList.add("grey");
    card.querySelector(".checkbox").disabled=true;
  });
};

function ungrey() {
  document.querySelectorAll(".card-setactivity:not(.selected-card)").forEach( (card) => {
    card.classList.remove("grey");
    card.querySelector(".checkbox").disabled=false;
  });
};

function clickable(card) {
  card.addEventListener("click", (event) => {
    if (chosenActivities === numberOfDays * 3) {
      console.log(chosenActivities);
      grey();
    } else {
      ungrey();
      if (card.classList.contains("selected-card")) {
        chosenActivities -= 1;
        card.classList.remove("selected-card");
        card.querySelector("input").checked = false;
      } else {
        chosenActivities += 1;
        card.classList.add("selected-card");
        card.querySelector("input").checked = true;
      };
    };
  });
};

