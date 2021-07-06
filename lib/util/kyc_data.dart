import 'package:meta/meta.dart';

class ImageData {
  final String id;
  final String imageTitle;
  final String imageDescription;
  final String imageAddress;

  const ImageData({
    @required this.id,
    @required this.imageAddress,
    @required this.imageTitle,
    @required this.imageDescription,
  });
}

const imageList = [
  ImageData(
    id: 'id-001',
    imageTitle: 'Conference Rooms',
    imageAddress: 'assets/images/kyc/conferenceRooms.jpg',
    imageDescription:
        'As an adjunct to the learning infrastructure at the KCC Institutes, several air conditioned conference rooms located on different floors and blocks at the Institute provide a venue for small groups of students to interact with each other, prepare for mock interviews and group discussions (GDs) organized by the KCC Placement Cell, and attend presentations made by guest speakers from industry and business. Our air conditioned conference rooms are fully equipped with the latest audio video technologies which can connect to the Internet on demand. Conference rooms are also used to conduct seminars as well as to screen learning videos under faculty supervision.',
  ),
  ImageData(
    id: 'id-002',
    imageAddress: 'assets/images/kyc/computerLab.jpg',
    imageTitle: 'IT Infrastructure',
    imageDescription: '',
  ),
  ImageData(
    id: 'id-003',
    imageAddress: 'assets/images/kyc/auditorium.jpg',
    imageTitle: 'Auditorium',
    imageDescription: '',
  ),
  ImageData(
    id: 'id-004',
    imageAddress: 'assets/images/kyc/canteen.jpeg',
    imageTitle: 'Canteen',
    imageDescription: '',
  ),
  ImageData(
    id: 'id-005',
    imageAddress: 'assets/images/kyc/library.jpeg',
    imageTitle: 'Library',
    imageDescription: '',
  ),
  ImageData(
    id: 'id-006',
    imageAddress: 'assets/images/kyc/hostel.jpg',
    imageTitle: 'Hostel',
    imageDescription: '',
  ),
  ImageData(
    id: 'id-007',
    imageAddress: 'assets/images/kyc/labs.jpeg',
    imageTitle: 'Labs',
    imageDescription: '',
  ),
  ImageData(
    id: 'id-008',
    imageAddress: 'assets/images/kyc/lectureHall.jpg',
    imageTitle: 'Lecture Halls',
    imageDescription: '',
  ),
  ImageData(
    id: 'id-009',
    imageAddress: 'assets/images/kyc/seminarHall.jpg',
    imageTitle: 'Seminar Halls',
    imageDescription: '',
  ),
  ImageData(
    id: 'id-010',
    imageAddress: 'assets/images/kyc/hostelCanteen.jpeg',
    imageTitle: 'Hostel Canteen',
    imageDescription: '',
  ),
];
