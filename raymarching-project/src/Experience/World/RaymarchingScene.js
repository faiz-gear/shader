import * as kokomi from 'kokomi.js'
import raymarchingSceneFragShader from '../Shaders/RaymarchingScene/frag.glsl'

export default class RaymarchingScene extends kokomi.Component {
  constructor(base) {
    super(base)

    this.quad = new kokomi.ScreenQuad(base, {
      fragmentShader: raymarchingSceneFragShader,
      shadertoyMode: true
    })
  }

  addExisting() {
    this.quad.addExisting()
  }
}
