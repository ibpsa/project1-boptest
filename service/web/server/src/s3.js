import {
  DeleteObjectCommand,
  GetObjectCommand,
  ListObjectsV2Command,
  S3Client
} from '@aws-sdk/client-s3'
import { createPresignedPost } from '@aws-sdk/s3-presigned-post'

const s3 = new S3Client({
  endpoint: process.env.BOPTEST_INTERNAL_S3_URL,
  forcePathStyle: true,
  region: process.env.BOPTEST_REGION
})

export function createUploadForm(params) {
  return createPresignedPost(s3, {
    ...params,
    Key: params.Fields.key
  })
}

export function listObjects(params) {
  return s3.send(new ListObjectsV2Command(params))
}

export function deleteObject(params) {
  return s3.send(new DeleteObjectCommand(params))
}

export async function getObjectBody(params) {
  const response = await s3.send(new GetObjectCommand(params))
  return response.Body.transformToByteArray()
}
