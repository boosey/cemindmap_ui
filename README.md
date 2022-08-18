# cemindmap_ui

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


docker login -u=ce-browser-project+byoi_ce-browser-ui-pipeline_pushbot -p=OZONT186K39W7EE4BXXWTUDRU9YHPYOPK8HVR1GBSZHWX0KYN6HC1S3KXHD8F6CG registry.cirrus.ibm.com

docker tag cemindmapui:1.x registry.cirrus.ibm.com/ce-browser-project/ce-browser-ui-pipeline:1.0
docker push registry.cirrus.ibm.com/ce-browser-project/ce-browser-ui-pipeline:1.0
