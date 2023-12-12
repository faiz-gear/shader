import * as kokomi from 'kokomi.js'
import * as THREE from 'three'
import TestObject from './TestObject'

// 负责创建场景内的所有物体
export default class World extends kokomi.Component {
  constructor(base) {
    super(base)

    this.base.am.on('ready', () => {
      document.querySelector('.loader-screen')?.classList.add('hollow')

      const skybox = this.base.am.items['skybox_hdr']
      skybox.mapping = THREE.EquirectangularReflectionMapping // 立方体贴图映射
      this.base.scene.background = skybox

      this.testObject = new TestObject(this.base)
      this.testObject.addExisting()
    })
  }
}
