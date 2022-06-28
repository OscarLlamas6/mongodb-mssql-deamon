<template>
  <div>
    <h2>Registros almacenados en MongoDB</h2>
    <h6>Los registros se actualizan cada 15 minutos</h6>

    <b-container class="bv-example-row">
      <b-row>
        <b-col sm="3">
          <div>
            <b-form @submit="onSubmit" @reset="onReset" v-if="show">
              <b-form-group id="input-group-1" label-for="input-1">
                <b-form-input id="input-1" v-model="form.primaryName" type="text" placeholder="Nombre primario"
                  required>
                </b-form-input>
              </b-form-group>

              <b-form-group id="input-group-2" label-for="input-2">
                <b-form-input id="input-2" v-model="form.originalName" placeholder="Nombre original" required>
                </b-form-input>
              </b-form-group>

              <b-form-group id="input-group-2" label-for="input-2">
                <b-form-input id="input-2" v-model="form.startYear" type="number" placeholder="Año de inicio" required>
                </b-form-input>
              </b-form-group>

              <b-form-group id="input-group-2" label-for="input-2">
                <b-form-input id="input-2" v-model="form.endYear" placeholder="Año de finalización " required>
                </b-form-input>
              </b-form-group>

              <b-form-group id="input-group-2" label-for="input-2">
                <b-form-input id="input-2" v-model="form.runtime" placeholder="Runtime " required></b-form-input>
              </b-form-group>

              <b-form-group id="input-group-3" label-for="input-3">
                <b-form-select id="input-3" v-model="form.isAdult" :options="booleans" required></b-form-select>
              </b-form-group>

              <b-button block type ="submit" variant="primary">Insertar película</b-button>
            </b-form>

          </div>

        </b-col>
        <b-col sm="9">
          <b-table hover :items="items"></b-table>
        </b-col>
      </b-row>

    </b-container>


  </div>
</template>

<script>

export default {
  name: 'TablaPrincipal',

  data() {
    return {
      form: {
        primaryName: '',
        originalName: '',
        isAdult: null,
        startYear: '',
        endYear: '',
        runtime: ''
      },
      booleans: [{ text: 'Seleccione una opción', value: null }, 'Si', 'No'],
      show: true,
      items: [
        { ID: 40, Nombre: 'Dickerson', 'Director': 'Macdonald' },
        { ID: 40, Nombre: 'Dickerson2', 'Director': 'Macdonald2' },
        { ID: 40, Nombre: 'Dickerson3', 'Director': 'Macdonald3' }
      ]
    }
  },
  methods: {
    onSubmit(event) {
      event.preventDefault()

      if(this.form.isAdult === 'No'){
        this.form.isAdult = false
      }else if(this.form.isAdult === 'Si'){
        this.form.isAdult = true
      }else{
        return;
      }
      let data = {
          primaryName: this.form.primaryName,
          originalName: this.form.originalName,
          isAdult : this.form.isAdult,
          startYear: Number(this.form.startYear),
          endYear: Number(this.form.endYear),
          runtime: Number(this.form.runtime)
      }
      this.axios.post("http://localhost:9000/executeMovie", data)
    .then(response => console.log(response))
     
    },
    onReset(event) {
      event.preventDefault()
      // Reset our form values
      this.form.email = ''
      this.form.name = ''
      this.form.food = null
      this.form.checked = []
      // Trick to reset/clear native browser form validation state
      this.show = false
      this.$nextTick(() => {
        this.show = true
      })
    }
  }
}
</script>



<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}

ul {
  list-style-type: none;
  padding: 0;
}

li {
  display: inline-block;
  margin: 0 10px;
}

a {
  color: #42b983;
}
</style>
