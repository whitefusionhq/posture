// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import "../../../public/mvp.css"
import "@shoelace-style/shoelace/dist/shoelace/shoelace.css"
import "../../styles/index.css"
import { defineCustomElements, setAssetPath } from "@shoelace-style/shoelace"
import { Turbo, cable } from "@hotwired/turbo-rails"

require("@rails/activestorage").start()
require("channels")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
const images = require.context("../images", true)
const imagePath = (name) => images(name, true)

import "controllers"
import "../components"

setAssetPath(document.currentScript.src)
defineCustomElements()

document.addEventListener("DOMContentLoaded", async () => {
  await import("@github/time-elements")

  let scrollTop = 0
  addEventListener("turbo:click", ({ target }) => {
    if (target.hasAttribute("data-turbo-preserve-scroll")) {
      scrollTop = document.scrollingElement.scrollTop
    }
  })

  addEventListener("turbo:load", () => {
    if (scrollTop) {
      document.scrollingElement.scrollTo(0, scrollTop)
    }
    scrollTop = 0
  })
})
