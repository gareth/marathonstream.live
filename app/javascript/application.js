// Entry point for the build script in your package.json
import "@hotwired/turbo-rails";
import "./controllers";

document.addEventListener("turbo:render", function () {
  const url = new URL(window.location);
  const params = url.searchParams;
  if (params.has("_sudo")) {
    params.delete("_sudo");
    window.history.replaceState(null, "", url.toString());
  }
});
