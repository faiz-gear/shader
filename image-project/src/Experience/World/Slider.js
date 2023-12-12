import * as kokomi from 'kokomi.js'
import sliderVertexShader from '../Shaders/Slider/vert.glsl'
import sliderFragmentShader from '../Shaders/Slider/frag.glsl'

export default class Slider extends kokomi.Component {
  constructor(base) {
    super(base)

    this.ig = new kokomi.InfiniteGallery(this.base, {
      elList: [...document.querySelectorAll('.gallery-item')],
      direction: 'horizontal',
      gap: 128,
      vertexShader: sliderVertexShader,
      fragmentShader: sliderFragmentShader
    })

    this.ws = new kokomi.WheelScroller()
    this.ws.listenForScroll()
  }

  async addExisting() {
    this.ig.addExisting()
    await this.ig.checkImagesLoaded()
  }

  update() {
    this.ws.syncScroll() // sync scroll position
    const { current } = this.ws.scroll
    this.ig.sync(current) // sync gallery position
  }
}
