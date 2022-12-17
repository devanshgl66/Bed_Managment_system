import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ReceptionPageComponent } from './reception-page/reception-page.component';
import { AdminPageComponent } from './admin-page/admin-page.component';
const routes: Routes = [
  { path: 'reception', component: ReceptionPageComponent },
  { path: '', redirectTo: '/reception', pathMatch: 'full' },
  { path: 'admin', component: AdminPageComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
