import * as kokomi from 'kokomi.js'
import * as THREE from 'three'
import testObjectVertexShader from '../Shaders/TestObject/vert.glsl'
import testObjectFragmentShader from '../Shaders/TestObject/frag.glsl'

export default class TestObject extends kokomi.Component {
  constructor(base) {
    super(base)

    const params = {
      uDistort: {
        value: 1.0
      }
    }

    const geometry = new THREE.SphereGeometry(2, 64, 64)
    // const geometry = new THREE.PlaneGeometry(4, 4);
    const material = new THREE.ShaderMaterial({
      vertexShader: testObjectVertexShader,
      fragmentShader: testObjectFragmentShader
    })
    this.material = material
    const mesh = new THREE.Mesh(geometry, material)
    this.mesh = mesh

    const uj = new kokomi.UniformInjector(base)
    this.uj = uj
    material.uniforms = {
      ...material.uniforms,
      ...uj.shadertoyUniforms,
      ...params
    }

    const debug = this.base.debug
    if (debug.active) {
      const debugFolder = debug.gui.addFolder('TestObject')

      debugFolder.add(params.uDistort, 'value').min(0).max(2).step(0.01).name('uDistort')
    }
  }
  addExisting() {
    this.container.add(this.mesh)
  }
  update() {
    this.uj.injectShadertoyUniforms(this.material.uniforms)
  }
}
