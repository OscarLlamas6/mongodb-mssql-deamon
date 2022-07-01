
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { map, Observable, Observer } from 'rxjs';
import { AnonymousSubject, Subject } from 'rxjs/internal/Subject';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class ServiceService {

  url = '';
  ws = '';
  messages;
  private subject: AnonymousSubject<MessageEvent> | undefined;
  constructor(private http: HttpClient) {
    this.url = environment.server;
    this.ws = environment.websocket;
    this.messages = this.connect(`${this.ws}socket`).pipe(
      map(
          (response: MessageEvent): any => {
              let data = JSON.parse(response.data)
              return data;
          }
      )
  );
  }


    public connect(url:any): AnonymousSubject<MessageEvent> {
        if (!this.subject) {
            this.subject = this.create(url);
            console.log("Successfully connected: " + url);
        }
        return this.subject;
    }

    private create(url:any): AnonymousSubject<MessageEvent> {
        let ws = new WebSocket(url);
        let observable = new Observable((obs: Observer<MessageEvent>) => {
            ws.onmessage = obs.next.bind(obs);
            ws.onerror = obs.error.bind(obs);
            ws.onclose = obs.complete.bind(obs);
            return ws.close.bind(ws);
        });
        let observer: any = {
            error: null,
            complete: null,
            next: (data: Object) => {
                console.log('Message sent to websocket: ', data);
                if (ws.readyState === WebSocket.OPEN) {
                    ws.send(JSON.stringify(data));
                }
            }
        };
        return new AnonymousSubject<MessageEvent>(observer, observable);
    }
  executeMovie(movie: any):Observable<any>{
    return this.http.post(`${this.url}executeMovie`,movie)
  }
}
