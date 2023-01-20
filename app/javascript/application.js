// Entry point for the build script in your package.json
import "@hotwired/turbo-rails";
import "./controllers";

const hideSudo = function () {
  const url = new URL(window.location);
  const params = url.searchParams;
  if (params.has("_sudo")) {
    params.delete("_sudo");
    window.history.replaceState(null, "", url.toString());
  }
};

document.addEventListener("turbo:render", hideSudo);
document.addEventListener("turbo:load", hideSudo);
