import * as kokomi from 'kokomi.js'
import * as THREE from 'three'

import testObjectVertexShader from '../Shaders/TestObject/vert.glsl'
import testObjectFragmentShader from '../Shaders/TestObject/frag.glsl'

export default class TestObject extends kokomi.Component {
  constructor(base) {
    super(base)

    const params = {
      uDistort: {
        value: 1
      },
      uFrequency: {
        value: 1.5
      }
    }

    const colorParams = {
      themeColor: '#000', // 球体颜色
      lightColor: '#00ff88', // 漫反射光
      lightColor2: '#00e1ff' // 漫反射光
    }

    this.base.scene.background = new THREE.Color(colorParams.themeColor)

    /**
     * 注意：defines会根据传入的变量自动判断类型，由于fixNormal函数参数是浮点型，我们需要传入带小数点的数字，所以取了2.001这样的值。
     */
    const RADIUS = 1.001
    const SEGMENTS = 256.001
    const geometry = new THREE.SphereGeometry(RADIUS, SEGMENTS, SEGMENTS)
    // const geometry = new THREE.PlaneGeometry(RADIUS, RADIUS, SEGMENTS, SEGMENTS)
    // const geometry = new THREE.PlaneGeometry(4, 4);
    const material = new THREE.ShaderMaterial({
      vertexShader: testObjectVertexShader,
      fragmentShader: testObjectFragmentShader,
      // 作为宏定义defines传入Shader，用于fixNormal函数的offset参数。
      defines: {
        RADIUS,
        SEGMENTS
      }
    })
    this.material = material
    const mesh = new THREE.Mesh(geometry, material)
    this.mesh = mesh

    const uj = new kokomi.UniformInjector(this.base)
    this.uj = uj
    material.uniforms = {
      ...material.uniforms,
      ...uj.shadertoyUniforms,
      ...params,
      uThemeColor: {
        value: new THREE.Color(colorParams.themeColor)
      },
      uLightColor: {
        value: new THREE.Color(colorParams.lightColor)
      },
      uLightColor2: {
        value: new THREE.Color(colorParams.lightColor2)
      }
    }

    const debug = this.base.debug
    if (debug.active) {
      const debugFolder = debug.ui.addFolder('testObject')
      debugFolder.add(params.uDistort, 'value').min(0).max(2).step(0.01).name('distort')
      debugFolder.add(params.uFrequency, 'value').min(0).max(10).step(0.01).name('frequency')
      debugFolder
        .addColor(colorParams, 'themeColor')
        .name('themeColor')
        .onChange(() => {
          this.base.scene.background = new THREE.Color(colorParams.themeColor)
          material.uniforms.uThemeColor.value = new THREE.Color(colorParams.themeColor)
        })
      debugFolder
        .addColor(colorParams, 'lightColor')
        .name('lightColor')
        .onChange(() => {
          material.uniforms.uLightColor.value = new THREE.Color(colorParams.lightColor)
        })
      debugFolder
        .addColor(colorParams, 'lightColor2')
        .name('lightColor2')
        .onChange(() => {
          material.uniforms.uLightColor2.value = new THREE.Color(colorParams.lightColor2)
        })
    }
  }
  addExisting() {
    this.container.add(this.mesh)
  }
  update() {
    this.uj.injectShadertoyUniforms(this.material.uniforms)
  }
}
