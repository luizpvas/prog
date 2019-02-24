export default function loadYoutubeLazyLoad() {
  let nodes = document.querySelectorAll('[data-component="youtube-lazy-load"]');
  for (let i = 0; i < nodes.length; i++) {
    let node = nodes[i];

    let source =
      "https://img.youtube.com/vi/" +
      node.getAttribute("data-embed") +
      "/sddefault.jpg";

    node.innerHTML = `
      <div class="youtube-lazy-load-preview"
        style="background-image: url(${source});"
      >
        <div class="youtube-play-button"></div>
      </div>
    `;

    node.addEventListener("click", () => {
      let iframe = document.createElement("iframe");
      iframe.className = "youtube-iframe";
      iframe.setAttribute("frameborder", "0");
      iframe.setAttribute("allowfullscreen", "");
      iframe.setAttribute(
        "src",
        "https://www.youtube.com/embed/" +
          node.getAttribute("data-embed") +
          "?rel=0&showinfo=0&autoplay=1"
      );

      node.innerHTML = "";
      node.appendChild(iframe);
    });
  }
}
