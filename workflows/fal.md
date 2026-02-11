---
description: Route fal.ai requests to the correct fal skill
---

# /fal - Fal AI Workflow

$ARGUMENTS

---

## Task

This command routes fal.ai requests to the correct skill based on intent.

### Steps:

1. **Classify intent**
   - Determine if the request is generation, edit, upscale, audio, workflow, or platform

2. **Select skill (auto)**
   - Generate images or video: `fal-generate`
   - Upscale or enhance resolution: `fal-upscale`
   - Edit or style-transfer images: `fal-image-edit`
   - Text-to-speech or speech-to-text: `fal-audio`
   - Chain models with workflow JSON: `fal-workflow`
   - Pricing, usage, or model management: `fal-platform`

3. **Ask minimal clarifying questions**
   - Output type and format
   - Resolution or duration
   - Model preference (if any)

4. **Execute with selected skill**
   - Apply the chosen fal skill instructions

5. **Verify output**
   - Confirm format, resolution, and content constraints

---

## Usage Examples

```
/fal generate a product hero image in 16:9
/fal upscale this image to 4k
/fal remove background and add a soft studio light
/fal tts a 30-second narration
/fal build a workflow that chains image generation and upscaling
/fal check model pricing and usage
```

---

## Before Starting

If request is unclear, ask:
- What output type?
- Any model or style preference?
- Target resolution, length, or size?
