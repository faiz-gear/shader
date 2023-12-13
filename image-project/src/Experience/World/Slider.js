import * as kokomi from 'kokomi.js'
import sliderVertexShader from '../Shaders/Slider/vert.glsl'
import sliderFragmentShader from '../Shaders/Slider/frag.glsl'

export default class Slider extends kokomi.Component {
  constructor(base) {
    super(base)

    const params = {
      uDistortX: {
        value: 1
      },
      uDistortZ: {
        value: 1.5
      }
    }
    this.params = params

    this.ig = new kokomi.InfiniteGallery(this.base, {
      elList: [...document.querySelectorAll('.gallery-item')],
      direction: 'horizontal',
      gap: 128,
      vertexShader: sliderVertexShader,
      fragmentShader: sliderFragmentShader,
      uniforms: {
        uVelocity: {
          value: 0
        },
        uOpacity: {
          value: 1
        },
        uProgress: {
          value: 0
        },
        ...params
      },
      materialParams: {
        transparent: true
      }
    })

    const debug = this.base.debug
    if (debug.active) {
      const debugFolder = debug.ui.addFolder('gallery')
      debugFolder
        .add(params.uDistortX, 'value')
        .min(0)
        .max(2)
        .step(0.01)
        .name('distortX')
        .onChange((value) => {
          this.ig.iterate((maku) => {
            maku.mesh.material.uniforms.uDistortX.value = value
          })
        })
      debugFolder
        .add(params.uDistortZ, 'value')
        .min(0)
        .max(2)
        .step(0.01)
        .name('distortZ')
        .onChange((value) => {
          this.ig.iterate((maku) => {
            maku.mesh.material.uniforms.uDistortZ.value = value
          })
        })
    }

    // 鼠标滚轮滚动
    this.ws = new kokomi.WheelScroller()
    this.ws.listenForScroll()

    // 拖拽交互
    this.dd = new kokomi.DragDetecter(this.base)
    this.dd.detectDrag()
    this.dd.on('drag', (delta) => {
      this.ws.scroll.target -= delta[this.ig.dimensionType] * 2
    })
  }

  async addExisting() {
    this.ig.addExisting()
    await this.ig.checkImagesLoaded()
  }

  update() {
    this.ws.syncScroll() // sync scroll position
    const { current, delta } = this.ws.scroll
    this.ig.sync(current) // sync gallery position

    this.ig.iterate((maku) => {
      maku.mesh.material.uniforms.uVelocity.value = delta // 将delta速度赋值给mesh的uniforms
    })
  }
}
