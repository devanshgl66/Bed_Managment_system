import { Component, OnInit } from '@angular/core';
import {
  FormBuilder,
  FormControl,
  FormGroup,
  Validators,
} from '@angular/forms';
interface Ward {
  value: string;
  viewValue: string;
}

interface Priority {
  value: string;
  viewValue: string;
}
@Component({
  selector: 'app-reception-page',
  templateUrl: './reception-page.component.html',
  styleUrls: ['./reception-page.component.css'],
})
export class ReceptionPageComponent implements OnInit {
  patientDetailsForm!: FormGroup;
  fname: String = '';
  lname: String = '';
  wards: Ward[] = [
    { value: 'CASUALITY-0', viewValue: 'CASUALITY' },
    { value: 'GENERAL-1', viewValue: 'GENERAL' },
    { value: 'CCU', viewValue: 'ICU' },
    { value: 'ICCU', viewValue: 'ICCU' },
    { value: 'BURN', viewValue: 'BURN' },
  ];
  priority: Priority[] = [
    { value: 'l', viewValue: 'LOW' },
    { value: 'm', viewValue: 'MEDIUM' },
    { value: 'h', viewValue: 'HIGH' },
  ];
  constructor() {}

  ngOnInit() {
    this.patientDetailsForm = new FormGroup({
      patientId: new FormControl('', [Validators.required]),
      fname: new FormControl(''),
      lname: new FormControl(''),
      allocationType: new FormControl('', [Validators.required]),
      requestedDate: new FormControl('', [Validators.required]),
      requestedTime: new FormControl('', [Validators.required]),
      requestedBy: new FormControl('', [Validators.required]),
      ward: new FormControl(''),
      priority: new FormControl(''),
    });
    this.fname = 'Ayushi';
    this.lname = 'Srivastava';
  }

  onSubmit() {
    if (this.patientDetailsForm.valid) {
      let payload: any = {};
      payload.patientId = this.patientDetailsForm.controls['patientId'];
      payload.fname = this.patientDetailsForm.controls['fname'];
      payload.lname = this.patientDetailsForm.controls['lname'];
      payload.allocationType =
        this.patientDetailsForm.controls['allocationType'];
      payload.requestedBy = this.patientDetailsForm.controls['requestedBy'];
      payload.requestedDate = this.patientDetailsForm.controls['requestedDate'];
      payload.requestedTime = this.patientDetailsForm.controls['requestedTime'];
      payload.ward = this.patientDetailsForm.controls['ward'];
      payload.priority = this.patientDetailsForm.controls['priority'];
    }
    this.patientDetailsForm.controls['patientId'].setValue('');
    this.patientDetailsForm.controls['fname'].setValue('');
    this.patientDetailsForm.controls['lname'].setValue('');
    this.patientDetailsForm.controls['allocationType'].setValue('');
    this.patientDetailsForm.controls['requestedDate'].setValue('');
    this.patientDetailsForm.controls['requestedTime'].setValue('');
    this.patientDetailsForm.controls['requestedBy'].setValue('');
    this.patientDetailsForm.controls['ward'].setValue('');
    this.patientDetailsForm.controls['priority'].setValue('');
  }
}
