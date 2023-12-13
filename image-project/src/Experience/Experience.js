import * as kokomi from 'kokomi.js'

import World from './World/World'

import Debug from './Debug'

import resources from './resources'
import Postprocessing from './Postprocessing'

export default class Experience extends kokomi.Base {
  constructor(sel = '#sketch') {
    super(sel)

    window.experience = this

    this.debug = new Debug()

    this.am = new kokomi.AssetManager(this, resources)

    // this.camera.position.set(0, 0, 5);
    // new kokomi.OrbitControls(this);

    const screenCamera = new kokomi.ScreenCamera(this)
    screenCamera.addExisting()

    this.world = new World(this)

    this.postprocessing = new Postprocessing(this)
    this.postprocessing.addExisting()

    this.update(() => {
      // 更新RGB位移滤镜强度
      this.postprocessing.ce.customPass.material.uniforms.uRGBShift.value = Math.abs(
        this.world.slider?.ws.scroll.delta * 0.001
      )
    })
  }
}
