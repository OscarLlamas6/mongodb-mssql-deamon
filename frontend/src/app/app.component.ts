import { ToastrModule, ToastrService } from 'ngx-toastr';
import { ServiceService } from './service.service';
import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'frontend';

  originalName = '';
  primaryName = '';
  isAdult = '';
  startYear = '';
  endYear = '';
  runtime = '';
  received: any[] = [];

  constructor(private service: ServiceService, private toastr: ToastrService){
    this.service.messages.subscribe(msg => {
      this.received = msg;
    });
  }



  sendMovie(){

    if(this.originalName != '' && this.primaryName != '' && this.isAdult != '' && this.startYear != ''
    && this.endYear != '' && this.runtime != ''){
      let isAdult = false;
      if(this.isAdult == 'Yes'){
        isAdult = true;
      }else if(this.isAdult === 'No'){
        isAdult = false;
      }else{
        return;
      }
      let movieValue = {
        primaryName : this.primaryName,
        originalName: this.originalName,
        startYear : parseInt(this.startYear),
        endYear: parseInt(this.endYear),
        runtime: parseInt(this.runtime),
        isAdult : isAdult
      }

      this.service.executeMovie(movieValue).subscribe(result =>{
        if(result.status === 201){
          this.toastr.success(result.data.resultado)
          return;
        }
        this.toastr.error('Ha ocurrido un error')
      })

    }else{
      console.log("dskjfal")
      this.toastr.warning('Todos los campos son obligatorios')
    }
  }
}
