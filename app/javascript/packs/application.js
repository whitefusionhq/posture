// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import "../../../public/mvp.css"
import "@shoelace-style/shoelace/dist/shoelace/shoelace.css"
import "../../styles/index.css"
import { defineCustomElements, setAssetPath } from "@shoelace-style/shoelace"
import "@hotwired/turbo-rails"
import Toaster from "../lib/toaster.js.rb"

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

const setNavBarsIcons = () => {
  const updateIcons = bar => {
    if (bar.querySelector('[href="/"] > sl-icon')) {
      bar.querySelector('[href="/"] > sl-icon').name = (
        location.pathname == "/" || location.pathname.startsWith("/?")
      ) ? "collection-fill" : "collection"
    }
    bar.querySelector('[href="/bookmarks"] > sl-icon').name =
      location.pathname.startsWith("/bookmarks") ? "bookmark-fill" : "bookmark"
    bar.querySelector('[href="/favorites"] > sl-icon').name =
      location.pathname.startsWith("/favorites") ? "heart-fill" : "heart"
  }

  updateIcons(document.querySelector("#topbar"))
  const mobilebar = document.querySelector("#mobilebar")
  if (mobilebar) updateIcons(mobilebar)
}

document.addEventListener("DOMContentLoaded", async () => {
  await import("@github/time-elements")

  setNavBarsIcons()
  Toaster.toastAll()

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

    setNavBarsIcons()
    Toaster.toastAll()
  })
})
