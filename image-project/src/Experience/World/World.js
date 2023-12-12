import * as kokomi from 'kokomi.js'
import * as THREE from 'three'

import TestObject from './TestObject'
import Slider from './Slider'

export default class World extends kokomi.Component {
  constructor(base) {
    super(base)

    this.base.am.on('ready', async () => {
      // document.querySelector(".loader-screen")?.classList.add("hollow");
      // const skybox = this.base.am.items["skybox"];
      // skybox.mapping = THREE.EquirectangularReflectionMapping;
      // // this.base.scene.background = skybox;
      // this.testObject = new TestObject(this.base);
      // this.testObject.addExisting();

      this.slider = new Slider(base)
      await this.slider.addExisting()
      document.querySelector('.loader-screen')?.classList.add('hollow')
    })
  }
}
